Return-Path: <linux-kernel+bounces-845472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B6BC5174
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8F3B3DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D01253356;
	Wed,  8 Oct 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwKnMQKO"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50311FCF41
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928444; cv=none; b=mn6Fn7ox4ST2tiY8FLCrNQSLEr0xulnu3UhfLT4KvhySbx2Z6eJAeq+9DVjquIjDSwC54Bh7ZKSHqNdnqapBX/wkFsKZpPoqnzMBK5upJfDLRb8J+0e4BHO3svkVTyKTB1fa3ta4J0nx4IQ1+2tzZSXuGRt0+BFCd6fDzh2Ai4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928444; c=relaxed/simple;
	bh=Xn7kzTEF/V6ednxDOkE1/Sg4/wO2XSCQ16Jb55Z1Ze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOXSA8Up5PMQMoxjNrJC/B46d3YvSHRHhtWym1ZU3tbPHzyw0VkYW6yCw6NM5ZocRSVqRImcWbTT8gw8o+s68/DPzyM/lkXkeq1/gr42+47rP7wDm4M3eYcLAT0TX1xBpYsJ5k1UHF3COpLs7oII2s9ZG4WqTd09zw6FfM3Vjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AwKnMQKO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330631e534eso8209898a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759928442; x=1760533242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LSe4ertuHY5UCTpJu4xbHCRSqUTutEtA/GWNFzMyBY=;
        b=AwKnMQKOaFoH/XFAA1/2aFogbjB90KoEfAiA3+7zP/LwFMKTRA842ob3V5opWrm8Lb
         FGrSK5MEw48bRJJvVG4T9bSYo0SKYtTjuSuvJLi+0CUllcNWvy6ccsXsj5g7bCYR1WHw
         /I8Egi5sASZojloStSr315jM7Q8g3bHIfqe8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928442; x=1760533242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LSe4ertuHY5UCTpJu4xbHCRSqUTutEtA/GWNFzMyBY=;
        b=G2dmKjX82nMl5gOyHcbtX6YL9alJkApkKSi3ohQc7eYmT3WZDegkcvdkk6Eq7BlR1F
         FIPyh115tP6H4LttmJEUx9+NPHxO0QqZgpgdhhNrjjcovLqZbSrPNslMi9Q3ZVMpOJZd
         sePFM13oFRxkexTEneG/GFHAZBkXS2ZkywSIUpY9PTs6ZR96PqIC8WNyEOGdnYJUGoI0
         qMSD1NrfNjsJwQz5mT/LzTy61oyZTSexvYSmnc619IlN1o9WUSLuwJOhrD4GhAkYq/W4
         mt6zDb6POaZ5ciURU8R1Poh1N8SFK9JvofB4xaQoBYdDNIDH0yrbBhTDw0VAXBaFvoQF
         gmMA==
X-Forwarded-Encrypted: i=1; AJvYcCV6+vgs+Wv7KKR5gzpUUF6fVGbBCNSbQGi8RP7Bbo334MoRObhMRUL2aIKMZynpMsRN+eCrES6PVvd3SSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhuiKhCl0hbsQIv+60kc41n7KEjxI6XT8dzk4qJHjjtGtX/BUT
	9UMlVQoDjqcjBTy8w4CRZ/PdjgyQWZmZQrH8PclVlplgn47N//yiO+HrlOcP0fpE2g==
X-Gm-Gg: ASbGncvDhqjQGZ68V1mBZZftu0BMiMhS9M8/7gEiJUqtEm6S3mPP6LVUN9E9yqcIR9y
	K7BaqZypiPDSwSSS99bo8lcldOAcpNV8vPeQGVQuDZzO+3TkNv+CcbsC9lM1Jjaj/y+bZ8GAFDA
	+2q6Iq1GLySDgamGeGBKnq4ef1CHf/ztFqPZV1Vhl4Zusjiws39WVlIJfO1xrijEMc0D7be82x4
	Eb4J1EFsdQDU8qxjasJ1gkh3Bpv+TqJVg+4khvtVRNsZoGcnZ6E3A3HLFE2aEf7l2h4VzuKAd2q
	LnK4Q53EBiPK+8J5R4p3H5TLKNtWKv+pY/4grTjoAVMCba08M4jZ5+yvomA8DCmoltYm+ZzCoVB
	1pFQxaYiz6C1jqzLcnRQ5TZNPdqzL2bQUF9lh3oicl9E0pVj371FZgAOrr8iwdXOF7ArOR4s=
X-Google-Smtp-Source: AGHT+IHp6lps6Tj0HDAkAwY/QdXKotjR6QS87QUoHQkIeAqcTqgqsc53Y+CMU+TaHQbQnjsgq+4XVw==
X-Received: by 2002:a17:90b:3e82:b0:32e:e3af:45f6 with SMTP id 98e67ed59e1d1-33b51112242mr4111189a91.10.1759928440572;
        Wed, 08 Oct 2025 06:00:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51113776sm3396141a91.14.2025.10.08.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:00:40 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:00:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Will Deacon <will@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: kvm: arm64: stable commit "Fix kernel BUG() due to bad backport
 of FPSIMD/SVE/SME fix" deadlocks host kernel
Message-ID: <qbiybep4kcm7hijtvg6qum4ubic37s6xnlzq2jvr5jwqjoffc4@htxzojej2zsv>
References: <hjc7jwarhmwrvcswa7nax26vgvs2wl7256pf3ba3onoaj26s5x@qubtqvi3vy6u>
 <aOYkuatjNVyiQzU1@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOYkuatjNVyiQzU1@willie-the-truck>

On (25/10/08 09:45), Will Deacon wrote:
[..]
> > We found out a similar report at [1], but it doesn't seem like a formal
> > patch was ever posted.  Will, can you please send a formal patch so that
> > stable kernels can run VMs again?
> 
> Yup, already queued up for stable:
> 
> https://lore.kernel.org/r/20251003183917.4209-1-will@kernel.org
> https://lore.kernel.org/r/20251003184018.4264-1-will@kernel.org
> https://lore.kernel.org/r/20251003184054.4286-1-will@kernel.org

Splendid!

> Sorry for the breakage.

No worries!

