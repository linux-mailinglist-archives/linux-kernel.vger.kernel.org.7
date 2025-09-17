Return-Path: <linux-kernel+bounces-821308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1640B80EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BB86256CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630134BA55;
	Wed, 17 Sep 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1M9yvuV"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F534BA59
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125879; cv=none; b=qj6reBCCRftzAUQcAHPpBn1raiJtfvaMvH0O719ZbSb5Lbj+wEME2zSOpnhyaJiRLHJnFXJNhk4QgvQuX1RNvcDkOi76ptElIXUUkwXxsoZtIN0jpqTDWlShztBcPf8uVZO6MEhg3wg6v6MTzOVhmCOYQEE64nzPzdSkUsZ6nT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125879; c=relaxed/simple;
	bh=t9NBOLHxyYWUxTCJ67GeHZh+kdZ522EcevTTLoASKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZkf4iiKKuqWMHN9LqwbdH4HzELzt4n+Y4raQBIofr6/AOr9jSpmowW3TTKsZsCHz/pTdSlMYGeJ6KSOREyvXJh9onSQV0xJ8QgZav2tuT7CHl8cGuYd6CRc8npYA6BKsPIBWjeAyahPoSk97gudK2SwCLeqlykHZG58YGN4rRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1M9yvuV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266cdf64so5905710a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758125877; x=1758730677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9NBOLHxyYWUxTCJ67GeHZh+kdZ522EcevTTLoASKRI=;
        b=F1M9yvuVisD/pmrYT43tJZ7r/o1eAEjiN6oQkpNb/z8ouJmlm7rLE3/sDkcDbR+t9A
         APMkaMisxRsYDS6fhTCDd+wae/XtIkQgqq7UkMfl/EgsjaccuQZYRI4bgWavSWh+rNEb
         JP0NN5pCukmSJvo+3xSPg+YNkVKAQNsaYQ8RT/7dqDewmQ0akjkr9Nbmwyumbt3evA4j
         WfEi+66PQNzG/gTAznUv7FsJSQtIEbzkSNQ8C8kZVpkHeSEI/2e+tgmhpgC6MAH/AeMc
         hRTin2Kf3Z2qdvDmHojKrBfQfQDWlNEBGJT7DoxkPqH9AjWiAMrwI4xbOoogCYBuaZIO
         S+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125877; x=1758730677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9NBOLHxyYWUxTCJ67GeHZh+kdZ522EcevTTLoASKRI=;
        b=KLfagky/8xUppCwOKYD1LB1j7ogQYPOP8HekvkinC8/FBq1Zw5J9M94j3sehLV9h1U
         FU1KNRvA7TsAjTt75VNuINleNKooe5I5zUvkB091Y9rKGzsoOgrLsJv78sYchiulVKtx
         bYB9k2NYbcJWNh9knp+ju5kDHx3STZQBzZQ8nalTDMESSmPFXFsVhxSLlgcRJ6RnBHQc
         xhnGQz0RKZXuI2HwgvsOgadbWiwHa3RMRVMceg1fVZcMrM1fJw+LIWekExJADjEP9GtU
         LBP2ahfY7jDYCrmG7ceupaeKRjoI0Ubj3A147t75CV7UbRnmVxkufw+eovfvy1m3bJ6z
         t/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICFQAs60vue7UgSYTi9MsYuymKb6aOGU/JLOhgkziWuQ4FjzJTyj2Pi3ZVOo8mbiHny/64vV83XJRNYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEj32obqixxY0+zHDcGm5HfvXURueNjTOpluIk/tGAwKk+P19i
	eqYdDxtrDlSbDnx5da9ypcL0euTdcGTV/lr3oPObZEs1et3zkcUCAZX/TA7Y7c7ZGyQq0n9Li+6
	V+PuZzbkd7tprVr92ggu30LXYQ7nFRQ==
X-Gm-Gg: ASbGncve5zb2bghrnH2G1/DhEzE+FGP0FJGD+QbR+9hu4hGJRVftnbGM21PgICibxAU
	igNyBPyI1aZaWclcvChOMgUECOPQ3IBb81twfLGwCasK+lThWDZebNtxUTVtyDqo4em8v7FRr1T
	aq0akjASv8dP9vNpfRVlX/hi5N0C5z0Jg+FOmw2JK0ivcPNCsMuAqHSm3komOe+LFMMXe6O19yn
	p4aS2E02oggyHF7y059nkm8
X-Google-Smtp-Source: AGHT+IHhWVMCTt4FqMqxsaSGtlsIXs228pgZwWTuHQW/DpH6t9agezpr14wLKdatbZd+xu+bC1vNCkjiD3OQGJe7Us4=
X-Received: by 2002:a17:90b:4c12:b0:32e:2059:ee88 with SMTP id
 98e67ed59e1d1-32ee3eb5a2amr3782547a91.6.1758125877216; Wed, 17 Sep 2025
 09:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801202359.794035-1-frut3k7@gmail.com> <20241009065051.51143-1-frut3k7@gmail.com>
 <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com> <CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
 <87ed4dr5pj.fsf@kernel.org> <CAKEyCaD-1GO1NL-=1E92BE9=XKa2PymOAY14vMmtwYGLsPjeUg@mail.gmail.com>
In-Reply-To: <CAKEyCaD-1GO1NL-=1E92BE9=XKa2PymOAY14vMmtwYGLsPjeUg@mail.gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Wed, 17 Sep 2025 18:17:44 +0200
X-Gm-Features: AS18NWB9R7Ie_lKbBliZB9szhNdDYZ285LPdqC-P9iVC3crG-nKLXWUxCy_BQt0
Message-ID: <CAKEyCaAaJGUX56Xp57KWkouCgpOyPNTqysRZyGtfsyoJ+ERMpA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The changes are added in the ath10k-ct driver:
https://github.com/greearb/ath10k-ct/commit/8f2254b8e0554e78efcef5fb752be0eb3573d281
Is there a chance they will be accepted here as well?

