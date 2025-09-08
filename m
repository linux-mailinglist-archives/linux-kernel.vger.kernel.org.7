Return-Path: <linux-kernel+bounces-806433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9DBB496BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871FA444A56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A730BBBF;
	Mon,  8 Sep 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwhXHDpF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDB30F7FF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351617; cv=none; b=o0BTUWP8VqDtIWK50062cP2qDa71qlxs+RDNTJgHbkZNhT8c4HM6GxTGVwU3dXk99ScuGa7q/v8XyGMeYeBc7zLRzev4r+9Ng2rB/WeVUG34Bz+xfltYn120HieSOd7GdEQlIFt3JOTqNDj89+QV7rqznNWyU5pTvhkn3cmFJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351617; c=relaxed/simple;
	bh=Ary2qEdINuj3SFVzWL6vHBjiROpx9PRgOxSO6BA+PFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9i5C/lxyE3yWPmv8sQhVD1fG/yx0Q4ziirR9igS0+0UF8jMThnFmKwZs32GxXGFkTYra6TjXt0Yv0k4nxzISV//ew1dtLe4b7n/1ZFLCoEBilLA5NRkNgUzEpb2lJzgTHvAcDfgpSk72mfmsJv3dw+lfqQhwz+y0dnXcDpEwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwhXHDpF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757351614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f5u862f+33I0ToIg9z8vAxXZhZpYtuEC4meBODLVdsg=;
	b=cwhXHDpFSCOi9Zgu9pf24LHC7o3dn1E1x75o/G6Gm7HHbiaQXipfJpRYg3ppG1FWFoqd4w
	5bBBSOQ/6evyFdUbt202uhXzcZSTDMklqkFl+IswcEICVez05kvL39MBocwUBm53ntdlMN
	t9QV3K/7g9UCIkMBmltfVP/kJzYIwyo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-hlO7EGSmM9uvnPtC5LdXCw-1; Mon, 08 Sep 2025 13:13:33 -0400
X-MC-Unique: hlO7EGSmM9uvnPtC5LdXCw-1
X-Mimecast-MFC-AGG-ID: hlO7EGSmM9uvnPtC5LdXCw_1757351613
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-812ae9acaecso719045885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351613; x=1757956413;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5u862f+33I0ToIg9z8vAxXZhZpYtuEC4meBODLVdsg=;
        b=PG+cGSDiuSMO9+0UiGFiOtTp9i1gO+1U7FFeSzwXS9uPIom1giiq6DSjw09sDEfvOD
         2K3NEinhJr1/9baxXcbv5qANEaByizJQAb4Aj/rA3PEqWk5aX63ZyPUrS6r/sx5aXY9u
         JzV1OY8n3onE6KbIvhx7vZ5mMVL/rgRyEOlUtKywvh/icFMg4eMd6RxcJwA4B4KCDhf1
         aMLWqkKQVzei+I2HI8kc2t4DCDrQdZkoJu52+9boLiOXAa298xBB6/wf8w1z9FIosmDt
         7qdfdXTEb/AuuR+TJGqHeHVrfKFuQGnOJUa+TGegXE6BCl968/xv2iB3HpXUTetJdjGP
         nWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIScrcZEb1apoWLdB+MNQHhCr8lQlLwAW3Nr3LoeGmFZdtKSc8iSVagg2+9gHNdaOvIq4RrvUAXoVjl/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WO147KpVeURlqBjC9uEYRmwLDkR9+cHxrSzb+EuxSziRIOHQ
	5KG/lDyWTc4XC7mI27+6o3pq4WLLR3DJCOIzvW2m8Cw5hGvlURApnvupiuJ6I8xSScNro71eLU1
	tJjQFobmi3kACvvByj3vz1vQbQeF7ygfiISG+RDEU+a9vhoLMLghlvrNZuLzIV0EcHA==
X-Gm-Gg: ASbGncuH87xmnbPZvXd/AGH7f3S7AupPOokLHEb4dnxq13Hmq2owqHu8DyIlQnQiOWd
	uKWVHMQzX/VYURuIzLAwmGsaT9cucD5gffTg682buBDofWYwcTkhx4gGSqY/LvXUM1WhvOQsLH5
	7YgMb9teVhEEWD/n5HQ1/GcoBIrbqk3Iu+zjpD6uGt3grSCipDzZDTrqpQt/4TPTdnIvHFKSzCU
	MKbYpqwfWc9ZvP3zK83OxHlVsJw4EKfv/16lRumP0kqAD7MDXMqlMv7+oaMXLe0t/vkRbwCm84m
	79YNnqc/xvHDiCVZS+457Njb1Vxz6o49XLWHVhXARhu7V3qeR/eg5SOe3Tw=
X-Received: by 2002:a05:620a:4589:b0:7e8:1d4b:b00e with SMTP id af79cd13be357-813c31ef062mr818167385a.30.1757351613097;
        Mon, 08 Sep 2025 10:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjCX6nGjgyfHMIgtZhE/2SgJwH/cNIdfnPyghhVtQtsXFicJtDPEijNhBgIwhV/6KVPSFsmg==
X-Received: by 2002:a05:620a:4589:b0:7e8:1d4b:b00e with SMTP id af79cd13be357-813c31ef062mr818162785a.30.1757351612499;
        Mon, 08 Sep 2025 10:13:32 -0700 (PDT)
Received: from x1 ([2600:382:8507:870e:b6f8:ee72:4f09:a16a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aabf586c5sm1108360485a.60.2025.09.08.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:13:31 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:13:29 -0400
From: Brian Masney <bmasney@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] clk: convert drivers from deprecated round_rate() to
 determine_rate()
Message-ID: <aL8OuWjlswr95xcB@x1>
References: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Aug 28, 2025 at 08:38:19PM -0400, Brian Masney wrote:
> Here's a minor v2 to my larger 114 patch series at
> https://lore.kernel.org/linux-clk/20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com/
> that only includes 8 patches where a v2 was needed. To reduce the noise
> in everyone's mailboxes I'm not including the other 106 patches that are
> still valid. I will supply a 'b4 am --cherry-pick xxx' command on the
> other cover letter to exclude the patches in this series.
> 
> This series has no dependencies and can be applied in any order.

I included a subset of these patches in this pull request to Stephen:
https://lore.kernel.org/linux-clk/aL8MXYrR5uoBa4cB@x1/T/#u

Brian


