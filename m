Return-Path: <linux-kernel+bounces-856595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C144BE48FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C274885FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486723EAB4;
	Thu, 16 Oct 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnQdXSbp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9A23EA93
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631716; cv=none; b=Y/sxtOPFG4/PqMt2qZCwemQfyHpcqS/Hw9lHzO7hFnNlN5nTFBj2zQg2YPBYJ5h5f3TdS2vSMn64AyazeU8uS0IpeV5IMcegGs4R5/SBI99hr6Ikc+4JowU3nOWaICy8SYfF9t+8+UHgFzst76tNwt5kR4oOSKxpJ7mEdGmBIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631716; c=relaxed/simple;
	bh=CA7cuB52W2mQEAqgkUGyrUbyJm9rGb31mdD8XpbhOA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkoBQ7D27U7zkrtBs/YLY7xjijhxIiScZPAFSowJNDK+l09PLYKRrxF2aMYuooOKrJCjCSqG8Cx7CvVIku0XEk4SPvRSM/GIc/VkdjiuGR4dk+Kt4lPhzB0AX5aBIyVpZRDJCWd75jvKX5mfAgjBfXzpI9ZsAoHHyM5jHn98fHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnQdXSbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CA7cuB52W2mQEAqgkUGyrUbyJm9rGb31mdD8XpbhOA0=;
	b=AnQdXSbpbaqc+pJ5AFJnZd1+MTaEZTpyYBLt8EOnkDZVB1Eb8qeY27XRzoeElMREOyyqFU
	ULmSwLwTk+m1meb1mBkYc35xQ4U6jO8z/oASHPsfsUXSm2qFCk9GpJ1V+Z2mEoeFWFiPJb
	kH9VDsKR3AvS9iQRFryMqyjNVnpncHY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-5aXk-ETMNYepD0HZaG10wA-1; Thu, 16 Oct 2025 12:21:51 -0400
X-MC-Unique: 5aXk-ETMNYepD0HZaG10wA-1
X-Mimecast-MFC-AGG-ID: 5aXk-ETMNYepD0HZaG10wA_1760631711
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88ec911196aso336350385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631711; x=1761236511;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CA7cuB52W2mQEAqgkUGyrUbyJm9rGb31mdD8XpbhOA0=;
        b=FkTnigBwqJLACNVXAgoQBbGbjkbk2qxwiRaIF/oEjCoagA6PjiGnbYwmU6Ms7O9G8Q
         ev7lsOUfHsL1ApilmIZtLGjrCmAymBE/B/5Tph1Vqt3MHPUPQ1LXZYlOHF25gSfITlTS
         ZWAoFA6Gx7ozLAiJo/oN6kzS14zlTdDjSQ/tC3UgFNRkSfT/owm90FiAYxjleKzY+aTb
         pJ14ShIKicK9svYgkU5QvjGWkQDDTeWNFp+AcO15cJQcu2liTzPYA1UcQhwjKjALlqQt
         UwMQAh8fBhdMqb1mTcB/COhiHKmS2jr9k8asT1TlavGpNBg60KaIvdT+4NYQT5OnmTzG
         O9mw==
X-Forwarded-Encrypted: i=1; AJvYcCUDmhT0Adsbsg4AZZheKXCUnGPfVlQnB/3jdJu6jieIi7oxSTOxt9IPBHFR0QXOf8X/o4BJWHSOKb8yJCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22xA2SLzszAvaHUl2HBXE2AHaDFCywirFLOymWv4ZGYznAahC
	zDbGN51A4MxnZ8W0t45WybyXoi0D/kMEArWINJ2eFX7YCGGlBZIz5YiUiL4gvv0xeKME3ssR044
	R9NFcFS2ukvLdn2t8IyTYZtpK67SH74TQBpfsy/lozM54f+5nVHm14NEWJt1FhaLF5g==
X-Gm-Gg: ASbGncs4ifMcaJKOhk+bn4RWWq1BbCkH7de3nsPN35fnHvIbb/itp/cSpnqvXaLdY4U
	2+RGEqqcvnkICQbcFdOxeE0bypYFOXW7Z4vPETqQBIABrmB4RjkmLHk/Pa0bgIkBJofMlwmGmvw
	4WQ+4cJeoIZ4DrTf02ttzdv/D0NP6ztSahYZrOojOzP3InIeRrpzmoRk+6dvYC5jICbmqNn94Zd
	OsAtYBS83gc//S6yH2DAfzV3PF07WXpIsyKAySJZWwuguOgF4jLUc98QUF5+0TndBC/xdlGXrR5
	hyPi449hrocRNAL+PXQOttgoEs6miqsGL4ZtOgx2CHqmwJx4X4i+8vg2xTymRZbgFB/mJqy2bIQ
	q6Jf9QaLmN3GX6NeZ/e7UPdew2pp7rDq7y5+BoJy+QxeizXrj2FdM7rSR0/7THGjFtw==
X-Received: by 2002:a05:622a:1a9f:b0:4b5:ea1f:77ec with SMTP id d75a77b69052e-4e89d091468mr10559561cf.0.1760631711003;
        Thu, 16 Oct 2025 09:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4xG1metr/rpLguKpcRm9DUmy+rwmLo2vG6JrUEiGqV+HAheQWldgSDUdPw7Kfed4P6HKKmw==
X-Received: by 2002:a05:622a:1a9f:b0:4b5:ea1f:77ec with SMTP id d75a77b69052e-4e89d091468mr10559121cf.0.1760631710594;
        Thu, 16 Oct 2025 09:21:50 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e885a8e10esm36941801cf.11.2025.10.16.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:21:49 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:21:47 -0400
From: Brian Masney <bmasney@redhat.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/9] phy: convert from clk round_rate() to
 determine_rate()
Message-ID: <aPEbm5qK8-hkV3w_@redhat.com>
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Vinod,

On Sun, Aug 10, 2025 at 06:45:28PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the phy subsystem using the Coccinelle semantic patch
> posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.

I'm hoping to get this series merged so that we can remove the round_rate()
clk op from the clk core. The clk maintainer (Stephen) mentioned this work
in his last pull to Linus.

https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/

Thanks,

Brian


