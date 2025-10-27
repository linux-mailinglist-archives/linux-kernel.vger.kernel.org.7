Return-Path: <linux-kernel+bounces-872612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29CC1192B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB45E4E4929
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9C3090CC;
	Mon, 27 Oct 2025 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0VRSVbB"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC881E5724
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601453; cv=none; b=XULqu7VFsVirwT4is0DWqEW7DgOuoDyy5eQXQ2JDO0HCRJxOyaGm4zbnmNzFU9n/GoTx3dFxDFrVcEoIHcifIZfXs4VzYxeuSeve4x7l7sqC3vvRn8XxcgdoDydKCNQC8MKw0BTox2wsVQppiSp0PyqVr1nGQ8eYudceaxjQdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601453; c=relaxed/simple;
	bh=LxgxfU9JMM/XXpT8Wu3S29fwvY9epDi1jI6+7QM3+XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmpL4LL2k8J2OC+BKP3dcOA0CjlMXMEt0gNZCjEt7XYAJ1EDX/zPRHTSmea+EyhBfU9ZwDZ0FzOxosSoZJEl3pcOCI3uSRtFxSgRXTtO28EvXVGmeqyznSukVpRe0L3ficmy3uaD2oLffTD75pLymkZB5mqsa6RCUpb46lGbcvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0VRSVbB; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63e336b1ac4so8367744d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601450; x=1762206250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LxgxfU9JMM/XXpT8Wu3S29fwvY9epDi1jI6+7QM3+XA=;
        b=G0VRSVbB1nlouViWV4uBOhaF/KSGnIgiHLjd92dWuHziHEfXU06J0YN1j3gWSwLV+o
         a/Rxe8JGJSowTMvX3hrsg2uN7nZzng5aYw7ffxGC+tNludqy0+6Asbd4yGKHK6N2OT32
         EOFNj+jwh/TsKPa19pBfwEli5YjKNHBSWwDMdo4Zy0fBsB0XKn7pDLdtMIA40wViHc73
         UgARJRyPAPCq8jy28JVdAF80HrxQlLObNBWrXILMqt5g4g/EMQS6CH9489ZaQ3gsF4fy
         U8iqeIRGhyfRr1JKoxbS9lX4iIJCJqDuWBGjJ3+oSGlmc+V/OaZoWlp9PvZTvn9LOyrI
         LSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601451; x=1762206251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxgxfU9JMM/XXpT8Wu3S29fwvY9epDi1jI6+7QM3+XA=;
        b=kw15Zbdli9oDf40WKWnd+zwb1bWtKDyjQv+042Gy4f0/cHUgQD794eP1Hks1Kl+ds5
         2ea/bBkschBqmigej/Q65L4Qe1zdnoziDnNED712sDZzprPkEj+cIa/Pq6k6o92eJzg4
         W3WLpzWPCF/sirF4/TNXV8t27rm3Ui3cAVHQ6j3kVW8p5ulHZF60rcuERqIifZrSzROd
         YT6i+1sHP9qhevLNMu59w4okq8Rc2WhDtJ0M9EaYrk/xcFI2ZIs24wbBM9TEu8uZTXot
         5HK7GProWgXcPjymTM0IgsFHHHzsgvzV2lINubFaKgH3a62Bm93hjikr/m9F7q5abz7J
         jwyw==
X-Forwarded-Encrypted: i=1; AJvYcCXnddZN1nfNRuCGG2AB03Asv37aWI3KlEeOKyHeN0sOeWkKiC+MqCoXaYV0xPyd0qxLJEl1T7nQz6snLyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqBK5lQA2P4uy7lLz8xLD8zCHz+8Ex+4aD8GdY1EQPXY1XpQm
	GQLLDlxkt//ahGrcQuicruMepefyqgRElEQ7KhOlyWf5eVZ3vl40gmtlUyi+dE0Tn31ou1E5q6m
	fgzzRleHbf+ZFvWpmhoeROm8nRMIZDx4=
X-Gm-Gg: ASbGnct3I6wZdv01nrhAIOE49LOf7HUrlYWD4+oMzoj9NOsbVG+I6iZn8ZisJ1uNEJB
	cTei+ddDn59qISIGDwqgTEjMH3qPND++QN2T7aFZeg7UKh0VsblOAH1/n8RWDhrWSLi2kowtcyh
	ToUJXs3MB7uNP4f22K2dM7J9KE0SEN0dYUzElT6y5wpncUEFuRHiArTUbCBWI3iFx8GSitUP6eo
	724Jqv+kpOb4RfmRJl8KogR3WSRaR2VOjfm1OeS8scKBn4PmBa+emw9D3e0GA==
X-Google-Smtp-Source: AGHT+IE+xFiChCzxtr04Z/m0hJHXOGlxlY9sghAP+YSn081Tu2Yfu+cfyqhlLSp9kON5CcS1j+2jjKy17bEmWlTePus=
X-Received: by 2002:a53:c04a:0:10b0:63f:471b:c949 with SMTP id
 956f58d0204a3-63f6c616129mr746893d50.8.1761601450688; Mon, 27 Oct 2025
 14:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 27 Oct 2025 14:43:44 -0700
X-Gm-Features: AWmQ_bnvV0t5ky6UFYQzbXnCp5WgpWnjg1KKi8IcxED3HM8eS9psFtrfoDd9czM
Message-ID: <CABPRKS9aLHfaiTH6YSa6E3d5gQab-tUEmPYbr59X-ybg1p5ErQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] nvme-fc: fix blktests nvme/041
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Justin Tee <justin.tee@broadcom.com>, paul.ely@broadcom.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Broadcom is currently evaluating this patchset and will provide feedback.

Thanks,
Justin

