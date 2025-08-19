Return-Path: <linux-kernel+bounces-775166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA0B2BC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF760624D30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30799315764;
	Tue, 19 Aug 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2X+fhPA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A931196A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592993; cv=none; b=SOVjY93tFuiLHV05e+ZlCpoRictg5ECWeXZhFXHsjood/1+a4XtgL+lsKvnMXzBwTQLvHO8NOiOpzKX6Rrws+SZv/7W/aRgc09NXV1HZIYdCgelvQ09uNmvaaB2ZZqeLn0h8ywc+AdqPiuNXiSE2ZC2wVfoSHaLn8p5rYjgoL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592993; c=relaxed/simple;
	bh=uiXQE0NRvooKnb00ZyDFhzitwmlzgW0GBH3yhlrAOPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3UVNvY9pkq/SroLclrGWt2wzzEW/5gvmASVd9426LxvFqTiYHkYKdwqBVkRQl/X8j5OoDgVShk/byEdsIIgafKBZHmnNd8IYCStF/DF5PXbNV16VhW1LRaIgPeO+4ESG2S2lVBinWTGdq6So0qSTESR8rP8xjY5p4y0ciobv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2X+fhPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755592988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nj9EkvlpuR2O71TRrkQ6effPG9eafUyoJmenDbBRkkc=;
	b=M2X+fhPA9EVj26o8htxf03SrDVHMNzg1djAdWOnMT9LoOzUL5ZfoxmEknULZ7PGahDUcnY
	fRGmRC5oEEHV4lZg8NftfLdCRzpm+Q5F4g/vlAS+ZMTdfYFed8xiVleMdEB4gkq5XwiTG/
	3PHhJkS3H4Goo8H9gGAZmorKBKnvkrQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-di2ZSJMKN1i1KvwON32_RA-1; Tue, 19 Aug 2025 04:43:05 -0400
X-MC-Unique: di2ZSJMKN1i1KvwON32_RA-1
X-Mimecast-MFC-AGG-ID: di2ZSJMKN1i1KvwON32_RA_1755592985
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c7ad98so186919251cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592985; x=1756197785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj9EkvlpuR2O71TRrkQ6effPG9eafUyoJmenDbBRkkc=;
        b=YT0mO8b9wWBBNypbebaT+fWA3m/FOrdGuQuCk2pPr8jfUAmqr3hUNcxwCrLyNNxT4z
         R4aueDh4ti93N3D9anIID1BbjYQj30Mznrf5I5HF4sOhTYcBogX7WQi6rFpDPIalTYA9
         VRud3IsGc1BlDufFQuz5OsmchbGZOo5gHzKD1X+YLy6wlz4TH6P/IbAq0y3LK2t7tYSZ
         1QVsAPsgVdHJp74SkBMcUzJIPSnv2GsZIR9bD23igl6sgiXcS0pok/Xv7YNv0obXY+6F
         xPA1VZwB1E6PhiN6e2S3FCXQqOoaQ/Gosmjp+4wy8WPtmVWokotolcU686r4iJ5xpdt1
         THGg==
X-Forwarded-Encrypted: i=1; AJvYcCWC1g6mI0MvO64lXbA/VoFJS8rlugnN5pb7iKlAG5LhKH34TYEiu3zAqeSiaBf8QadpBLVQmZB9jAQ7PR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqykIvjZi1HrnILqijeQQTl+4+AZvAZy7PfYtQcDxTRbczIPLx
	tTx99XQWNNB1VQNsIEOPlO8ZbO5hLd+nAropalcuhqCN3uiD6A6ba/a+aYN+CaRqEDPfJOZTMDT
	UFt1c9xI+6jzPSotfBlQgUhpgWu9Zw1cL0TyOTD9+X4y2ppoNCrZsr7WpXfqvrmWi1g==
X-Gm-Gg: ASbGncvpXtE+c6rppk6GmwbwtM9CFEoaT4J8fAy2CP8svvpSCt6kOgq4W996Uf5p9sK
	lfnbOgkebNSe4uiXmgxZGQl2Zw4MF6TZfr14+r0txTh6bBjKVDEQT6E6BGvgW1aDMlcAW0zrkp/
	HKsgRDrsJsUbrHAcvEQSJu5rhjqMgyNjqn66CtHMGCvRU5aDLWf5g9DI5bAH3JlmwTBRMqkWqjd
	VMtq53nVsSygvQ0jiRwSCapCxSiJgv2H+HlGxHFo4TwhvDVMtqTAwKcG/KekrG8kT4gNEA3hIsG
	Ph7vTnO5XSikJ8ORDUcAIu6ScwTLUYWCUxqfiK2V1DQb1riaOsH/wewl4npTcQz8qwJq2TgXIK0
	BAXFZ7dCJmxw=
X-Received: by 2002:a05:622a:4d03:b0:4af:1837:778e with SMTP id d75a77b69052e-4b286d9f7ebmr18161711cf.31.1755592985077;
        Tue, 19 Aug 2025 01:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7UB9FBrpGjQ2XSRXKjMIthoW12C3rhlMGUbObj2mrt2S/t/HnOA8M/IRXI4lKNYc+qncPA==
X-Received: by 2002:a05:622a:4d03:b0:4af:1837:778e with SMTP id d75a77b69052e-4b286d9f7ebmr18161561cf.31.1755592984715;
        Tue, 19 Aug 2025 01:43:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc19631sm63346241cf.12.2025.08.19.01.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:43:04 -0700 (PDT)
Message-ID: <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
Date: Tue, 19 Aug 2025 10:43:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Richard Cochran <richardcochran@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Carolina Jubran <cjubran@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 4:17 PM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce two new ioctl commands, PTP_SYS_OFFSET_PRECISE_CYCLES and
> PTP_SYS_OFFSET_EXTENDED_CYCLES, to allow user space to access the
> raw free-running cycle counter from PTP devices.
> 
> These ioctls are variants of the existing PRECISE and EXTENDED
> offset queries, but instead of returning device time in realtime,
> they return the raw cycle counter value.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi Richard,

can we have a formal ack here?

Thanks,

Paolo


