Return-Path: <linux-kernel+bounces-837504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B91BAC74F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE1619255B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE62F83DE;
	Tue, 30 Sep 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a26GaCmv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAC220F2A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227785; cv=none; b=tSzKgnsB3J3BnC3RBJB94WwoMPPlT4kcvl31jg4URsFtlxBx1YXY3RCcTaKeOXF2OjgtOll7b8pL5hc80DuesUaEG8ColpldzNCq+6+D0vTvE2sOdHpjsYap6HDbMroqZYCNuDxohPdFgSVVKN/aY5bZYsIQTkM7WcbODKLSxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227785; c=relaxed/simple;
	bh=iwETwjsWH8KkWnjdGAXqGGSLFku1lXN3pXfIWeiax2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzkzFYcurrrIlsbbW9ipaYGQfEqWWNngN8SEDWjTncnILtCuD31HFGIVdAoBkABkQAdQgyM/2gkvl8/6jUSHz91HCcKSTyNU/7LTdqJAuvKXKiVpEN691RLOv9vEv4THmo+YLiMfOJyQGMFL2MPjAouWGgyoiC2klRfpGAR0F+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a26GaCmv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759227782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgf+5bSh0KvMOHC6oH/iO2k9wdq3bzQfdz8vvpviODQ=;
	b=a26GaCmvjtOGXKkgtKZ7kDdb3lz6kjmiFM+yJ7WSn383o+Gbz8IQfGyaX3MsWXKdCN28vy
	rpEYlcqDNP/C0vCZRSLnxuBV2HTPmzlRfl11jMa0EMiIkhJmqe4cYboljLvcor5vq0DINB
	QsNgtW1cRGYMThlXrvZIXGKPfV1XVCc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-57__WuUVOQyf3lWgCOcjrA-1; Tue, 30 Sep 2025 06:23:01 -0400
X-MC-Unique: 57__WuUVOQyf3lWgCOcjrA-1
X-Mimecast-MFC-AGG-ID: 57__WuUVOQyf3lWgCOcjrA_1759227781
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-870d82c566fso87345385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227781; x=1759832581;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgf+5bSh0KvMOHC6oH/iO2k9wdq3bzQfdz8vvpviODQ=;
        b=MslMRyKbLDts8bEFpwONbrDxQhJNpxp0xIsJMqXRB3dWbxJG/xqsBQC9N/HQsyxuwK
         x0RU7PDEftPFBvF2Te1RLUjyMTye03H9HCdqgbDpztdSwP69NMD+VyeI+QbNGU3lA9Wl
         PiPlTSMVceHE2ReXkBHhO4BSRAsDdlwHjVb0xzE6QntAD7UPVeYK6G9Xi05y81rLkhsp
         302eeV/Mc8E/TvKbAz+7vb8u9JtnJTPY//FI/lzKry5XpudQRGbocW3UzeI+Ape1UrG4
         k14uh0mHvhcZuxo8OioN0Olve0DPqNz3D396XbtItebdLP3OaY0wgeEqvdxwfB4Mwaz3
         HwuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6l/uRi8drNlr/156/r0OK9l/9yNJGLa85yDXbw/66hFIMLPD/YYsn/9ITFPK4R7hPPgJnMPhrXUq6Rzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfNsKAtFJnWTWGgXB148B6RKm6ZJLfGk7fBndeKVUOTi3SdeP
	/Dq+wnRGJftmZsXDsKHvFWYm7mtmmN/QNB6yqr87s9dgVG2xtHquQrocMfoiixliX3+yVY6Uut2
	qEXLBHBvsJyXilugtFIwTkb9qA2FBgGpQTaPJtF6PSb8fgBxpIve5jANLHl6aKB4W7Q==
X-Gm-Gg: ASbGncvUGufQgeplDlYMOyAVH+WWIGTwJB0oSFdWvdjiATHyoJIDPgJuHzuqz8pPJf+
	T4znpaCrUkK635tKrfvaecZGQzi2zTGhf+PCj+Y1JI9ao4phbZvXp3BhOStvCmVS8ST6m7/i9zA
	+bmKW1pMPGkuZkFuAAUEt2J060TlbtYYCnTgzALARRaS56YIGzKp/Eh8NiOaTH2UJFvQuF9F74k
	RnUIEFa593L9dpsXDqdtgev3yXVZOb6BSc/Al5ZtyLwTCisdsOJFsWLMEgYVQpLgbypXyPIbx98
	w1SDRWNnDeJTfcHzwcV8x6zZbMmfIkn3kKyOjO1C92N2K1qcdjY8LYY8XmYBPb8C63vqioippeJ
	JxFYKxTLVUmbU9J5di2320PpEMc2pCYXfFsfR
X-Received: by 2002:a05:620a:a115:b0:871:dc2d:6026 with SMTP id af79cd13be357-871dc2d7504mr86159685a.16.1759227780677;
        Tue, 30 Sep 2025 03:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoByg3sSfWNNSEyfpGpiDYCBSbVHTJiJB2RdYaJ4CTo/cPLRB4Pivt12MeIkKx9oIwAdPV4A==
X-Received: by 2002:a05:620a:a115:b0:871:dc2d:6026 with SMTP id af79cd13be357-871dc2d7504mr86157585a.16.1759227780145;
        Tue, 30 Sep 2025 03:23:00 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2737869esm1013615585a.11.2025.09.30.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:22:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 06:22:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, dianders@chromium.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fix slab-use-after-free when
 clk_core_populate_parent_map failed
Message-ID: <aNuvghjOrY7nSviZ@redhat.com>
References: <20250929083119.2066159-1-yun.zhou@windriver.com>
 <aNrj60UeYQfXmlJ2@redhat.com>
 <a77dc81a-e8fa-4f9e-8915-3b8f352c114c@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77dc81a-e8fa-4f9e-8915-3b8f352c114c@windriver.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Yun,

On Tue, Sep 30, 2025 at 12:59:14PM +0800, Zhou, Yun wrote:
> Hi Brian,
> 
> Thanks for your review.
> 
> This defect is caused by multiple reasons, but as you said, the fixes tag is
> not accurate enough.
> 
> I think it should be:
> 
> Fixes: fc0c209c1 ("clk: Allow parents to be specified without string names")
> 
> Do you think so?

Yes, that's what I would make it. With that fixed in a v2, you can add:

Reviewed-by: Brian Masney <bmasney@redhat.com>

Also, just a heads up to not top post, and to reply inline next time.

https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

Brian


