Return-Path: <linux-kernel+bounces-867539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E5C02DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8D84ECDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE334B1B8;
	Thu, 23 Oct 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NSoGluIG"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F691474CC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243159; cv=none; b=AgHWIig8y/O5Vlqf7bpHafzL70fDlV8sHjaB7oSRuFXavBUrHEVBo1Hum5F9TDaKMUKk6DvhoEko8S8mKUauKfQyzjODhyWWPCzV19JwSYIyXeqkolRRXvFJf63D22kTfakZWDH8h9CnLvCPwGA8OKN6HUP74VcD+Ksj19Q7lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243159; c=relaxed/simple;
	bh=LBnfKUDTw6Ut96cNOQwpeXVHk5a80pg/4FNF9IBsbZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTVyZpPRwIttkmOHWfyPK0ZD6FPXG0Oe0eKCEd5u1/dNzycOnU+ZDZ1he2jxpxxisadA1ypxnHZqPwm2aKMybl67we6tBzVhwGSOyisoeo8Jvm2zb9CFI3LnlWsWQIpok+2fz1gObqg9kWB+VY2mu4FXpnelMzFE7IBjaTrJotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NSoGluIG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b67684e2904so830755a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761243157; x=1761847957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOU/kElSaCjd9f7zwYG7ZjeJEeWR4TSXwf/lG3jqcY8=;
        b=NSoGluIGHY41qA1OvvpOTRQQ5esruNqNo4EHESFCOygz2LIXbSEHSXHs7deAX4PFeZ
         jegp4+YGfzSsFhazKbAOAeSSjcuUv8LdEMvCRlIHZkk6lAT3uIv10lH7rPmDcW0VONSv
         A1M5yozih/39ctEtvZp5+l3kVD4Ql9wQ4Ob4NHQiUOFM7eHQNk+BSd5OnhsbTg8f8Is/
         W2JvXpFfixNPmTe4zPfRMSm9Z2ASWiFfI6uw9tKEweWYGoZUqERgTEphct0w27cTTuF/
         GyzUFGXN/raAqVb1HNrbebflcqiXT83q/tAyKiFrJdyL2HAadrXAwXR61J1e6k/s2+0U
         +XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761243157; x=1761847957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOU/kElSaCjd9f7zwYG7ZjeJEeWR4TSXwf/lG3jqcY8=;
        b=H4/j647pNcA8wFkELy/vI2Mat2XyORJcVH4IoIDPpD5we5SwjhZNfx2qpbA5iRstTJ
         u2h1J547DTADAfHtcjMGFaQGki7uohaHmmZ4JcHRfJ0gctgPWfz4J/cAx73iLSEMIPT7
         MuVyvAr1cwN40YfYUnovu8uteyINLdAfyV2No1Hb0UOVkz8p8AUz2r6MXJlzr1Dgy22o
         dYIDkl90PCvc1sXKbZdUf+vuIo4yrPDk71zbfIG/ZHegxPQLu76+issLkEA592xUxuhH
         VPHQxhz6sf74f1oPiYvq3E+2FNLF0+8duopMEi0CVrA8XKhwFJ+63oZ8SW9dL+h/312R
         +HaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYyU6rNbtsnN3egtzBEkURkBR3P0/v2be8dHenjc1CSJufl+HcqwxTDpQvbKR1ChwnkssHOEKA1dY+46A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//FZKODZN742X2qpD4RCLvatd7suWZ1w/hX1KDYUv+n93gj1p
	05UeC/8O1xwRm09fK6Lys7sVLr+JNgrXk4fxFAYMNwb6jwQ9o3rECxcO9hscVvoFsos=
X-Gm-Gg: ASbGnctdcpfVxnk5F7vyiWy9dP/KXbGS5Gs0W/tFfCMxS3f9zkuQAZ4NkXDI2tRwvLh
	h7z+GU+knz4NbilGXviy64NJevBxXdcAgrpw7S4qqE7jofEwO964FyBCHjwg/cgoRwzRYCKBRee
	TldPaCTWo2wqQQGNL/Ku0BUv/YSW+An5/TFyqLTikwgEhplIFnOCbug3OB2fG11SIKjmr1jPAcD
	vqvIaIYtFdjKBbQieg5fwe1YQhJqzDh/wU3W4TeGpD6QP+t0vhDjyN3BYu7IpCVV77c3mCUFXY6
	TnuU6JpJzc0yJSxSbCXPDf1CqLqQRJ4wwPrfRSBQLO7MBmnns9R41yBsjnS16OltnIOVpC4IzUS
	xlT8U2dqE1qnsL0D7WbU4UC1PCxSKCfw7CpTVShjhY4boHgWIN4EPzrJlT1HN
X-Google-Smtp-Source: AGHT+IF1WEdpusCP+BeMXzNhxGYpnraKs8rtFDbaJHh+VNXtmmVcLIGFG75EjXdN+9DNv8IrhqEt/A==
X-Received: by 2002:a17:902:e743:b0:290:ad79:c613 with SMTP id d9443c01a7336-290cb27c76cmr315785155ad.47.1761243156831;
        Thu, 23 Oct 2025 11:12:36 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2578desm29726705ad.106.2025.10.23.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:12:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBznf-00000003Bqs-16NV;
	Thu, 23 Oct 2025 15:12:35 -0300
Date: Thu, 23 Oct 2025 15:12:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Reaper Li <reaperlioc@glenfly.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: fix probe device bug due to
 duplicated stream IDS.
Message-ID: <20251023181235.GH21554@ziepe.ca>
References: <20251011023003.159922-1-reaperlioc@glenfly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011023003.159922-1-reaperlioc@glenfly.com>

On Sat, Oct 11, 2025 at 10:30:03AM +0800, Reaper Li wrote:
> From: Reaper <reaperlioc@glenfly.com>
> 
> Commit 9246b487ab3c ("PCI: Add function 0 DMA alias quirk for Glenfly Arise
> chip ") add quirk to fix hda dma request issue, but IORT logic populaties
> two identical IDs into the fwspec->ids array via DMA aliasing in
> iort_pci_iommu_init() called by pci_for_each_dma_alias().

I'd rather we not have duplicate IDs in the same fwspec, can we avoid
that at the source?

Jason

