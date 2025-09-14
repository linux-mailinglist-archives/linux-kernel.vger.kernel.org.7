Return-Path: <linux-kernel+bounces-815563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B845B56835
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FC172833
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A67235072;
	Sun, 14 Sep 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBIUvd4f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96A20322
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851298; cv=none; b=brFCBo8u2Bn52EGfJ8iob3WZvxcGhEwtMxFXIwSv8mcsOgqThUL3noPio6bfee86NzXFO4w03Nf+40YFECD4IsX6y9VuwdylUEKA9WW0EjT/drU5aBvEgEjdy7GCxwttTiyRbGrzr6o4mFR5SFEcpuyQgXg6BuP0cijBm4Q5aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851298; c=relaxed/simple;
	bh=QVrK1epjSFOqMcmLXFJpk1n4b5xh+bz113bGJLTt1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxdqTP1hJP293JI9r9wKckECOUrps4PEV2fLKRVT+MLCdef3NdiR8gk/gfc1YE4bz2VUwbU1OVPWy/JRj+TBX2uz1H1jpZ2+T7/wx5lo+5Hr3+rgUwtjFsigdI3uGCWSUSw5f7SFDgms+GT9GI9e01KaMcsJRULxGSWfIWTCaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBIUvd4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757851296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/P2pmY9erGP27JX1LIX0xO5lGm9xSowmXkGs5Snrvk=;
	b=gBIUvd4fckGN6RTSALzJN7JsqnAWkaPUNRxZTxXlSayx2VuepzmF4aWT7uj4OoJUKz6Eg0
	tSjz/jnuU32SZUMQ7sqSZbdA51H1xKV1aPLaY/eUzGG7W5og2jE9/N+k1gDjvPzWrq/loE
	peL4G1PMZ+vdcg4v0QbxUa+Hqx8kcpo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-8MixuT8bO6qd2Scu-Np6uw-1; Sun, 14 Sep 2025 08:01:34 -0400
X-MC-Unique: 8MixuT8bO6qd2Scu-Np6uw-1
X-Mimecast-MFC-AGG-ID: 8MixuT8bO6qd2Scu-Np6uw_1757851294
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8063443ef8cso1260006985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851294; x=1758456094;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/P2pmY9erGP27JX1LIX0xO5lGm9xSowmXkGs5Snrvk=;
        b=vPR5q9It5fSfsw0Su86XDzDd/SwvboPVqbe5RnS8T088vPGIOY57wouY5Ev8+eE2Mk
         RWzU7KZL8CfWXRro7E7e2iSUnOrm4JWCCeUu91q9TbQvTApZakEkPw2uLyrE4Y4HfG9J
         4ikkjgjXzICJssKPJ5ys+qD2CRdohWWBNO7+KdIVgzlcLwQTDDcRLA7aSvZIwc8W5g5r
         FY3yWLiZlUNBmGwMmRKBW5xpkuqbyi4VmZ7gs7XMu6NvlpFInQiRhCW9oBSJcRtU0DID
         KQLH7uTgxnLBMzrL+lex7ODTHCvziXcopWnVgS1B8T1N+NO3AvXBPaDNbhx3HmLEmGcf
         bNCA==
X-Forwarded-Encrypted: i=1; AJvYcCUWB/V7azYY9x3mDpiDv4H1XBrvNxEwNQTkrtc8bg6dsfMMBE9Yq/ICt1tm5/IVHzStcZFsdiwT/Jq/1/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xlfhuj0TCi6RsHEtenIPkEKw7LUEEJlIZueLjbi/g/UpVgj7
	Iilgpv+z5cJRxG7YRqihpetAvMEfcriUYgwivTjxt1ZC76oUps80L67tCFFFR3R0HJyYq9ddfNQ
	xjsNee3Oea6haAGCl9LwRzb7BMfsR0407j2DqCh0MFZ7ydq3KoT60EbeNZXkUGDW8Uw==
X-Gm-Gg: ASbGncsKUM+H0bQzsC1ZfmRYJXESP9VRF3IuH/MH4P2xAemX/nZOs7RM0r+DLVlTCgc
	yUAs3mOFNCSpOtGF0zYNcrmEco6lpJAFq35e9TGB9jJqQkmZSnOoqP4PRE02WaoE/1eW51i+jkB
	6DSh8YVRMIch4HDKgDG/OqV23bvVTNa/k3Os1ekBPCUvDJpq7a/5QZIiJoWkMjg7hIGPw36BJ+V
	Q2EIyNn7W9wN08/AK9qdq9WEPJA+PZBPbDHG3gVefKmxLBHVSjDP6OsQjxk0D3xYLZfXyjE8X+n
	fLukurmLDv13sLWZMct072+bc99hj4hKw1GykLFXHIZNgJ6Th6ZJMqeevp+eDTX/SM6BMDMf7kq
	eJieLkpaHTLnkktWh77i6quRPend1aH8=
X-Received: by 2002:a05:620a:1a18:b0:7e8:3fec:5e61 with SMTP id af79cd13be357-823fb826048mr1027927385a.7.1757851294094;
        Sun, 14 Sep 2025 05:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIsrBfOXyBwmvGT0Kz8IZrStEjhdVLehZi62PDrHPdMWX397mJ04MxVHeqPCuDiG+BC8R/RA==
X-Received: by 2002:a05:620a:1a18:b0:7e8:3fec:5e61 with SMTP id af79cd13be357-823fb826048mr1027921885a.7.1757851293541;
        Sun, 14 Sep 2025 05:01:33 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7942d706dsm16096071cf.23.2025.09.14.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:01:32 -0700 (PDT)
Date: Sun, 14 Sep 2025 08:01:31 -0400
From: Brian Masney <bmasney@redhat.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: busses: bcm2835: convert from round_rate() to
 determine_rate()
Message-ID: <aMaum0Lv4C9B3Mzt@redhat.com>
References: <20250810-i2c-round-rate-v1-1-9488b57153e7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-i2c-round-rate-v1-1-9488b57153e7@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi all,

On Sun, Aug 10, 2025 at 06:32:18PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian


