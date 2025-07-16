Return-Path: <linux-kernel+bounces-733167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB55B07116
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781F516B11F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22A2EF9C1;
	Wed, 16 Jul 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Irr1jidL"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97628B4EA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656828; cv=none; b=fr34JVdp7WVCiwbVnDCe23unueMb65r4x0H/tL4dDGwPeYLgzuvalpKqf/N7ouEXUTtfLzgkZqSpFcGlC8QaXH5U4ecxy9qcWTYWzfrTt9ouYGWccj+uUWpb/a/Zt2xATF7iJ+GhnKW+t/7iTb4ogeQ94uLGwrQlO+1Qe4PyBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656828; c=relaxed/simple;
	bh=snu8pRbxtL7EyXfOuCqadiLZhbMnHxEmMNZD9Vr2iKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UNemGIIiQRpih1gLPLu3TNMwfn2FhNWAtjrH1YIUYCmwrHdBujCN7TrPZn2EmN/tCviSmxPE6P47vSs7N8Lw3ei1+ErR4BT41iuEezqPNvC8apxfRsOIRXNGCCdDz0gJSslZXbKE1HrkPXLfQfJEqqwS13kiv0OwBK5AOkh6PXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Irr1jidL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250716090657epoutp0170614e5d87644660d9ddc51a3acfcfbe~SsBbgdYFL0162801628epoutp01u
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:06:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250716090657epoutp0170614e5d87644660d9ddc51a3acfcfbe~SsBbgdYFL0162801628epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752656817;
	bh=UK+cRw6BHYgTBmSStxePjW4JegDUuN5eHUVjHh3Sfsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Irr1jidLTOmi+AAPyuMjxI+Y4ICrCtctTwbCaiRkiKyBAhCgsj8PbxAqxOqctB8h0
	 aFEtA4K/Y/W+wCpqEDNjz/N+4HU9nb2cXX7YX+Et7TNuUvTxXOZL/w9xyoyUP6bWK5
	 sVqBDrF0UVHJ0B5ZxTwEuWJUGtsc7GZyc3DHOTaU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250716090656epcas5p26d47c2071c38c26bf298cb3102ff6783~SsBbNtVV03245832458epcas5p2z;
	Wed, 16 Jul 2025 09:06:56 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bhqtm1zgSz3hhT4; Wed, 16 Jul
	2025 09:06:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250716084412epcas5p4c412b3a6b918366d7548c3c97e772ad6~SrtkYPm0t1570715707epcas5p4T;
	Wed, 16 Jul 2025 08:44:12 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250716084411epsmtip29395a4ec2326d3467d11e1e96bcff583~Srtjc1HHi0326203262epsmtip2F;
	Wed, 16 Jul 2025 08:44:11 +0000 (GMT)
Date: Wed, 16 Jul 2025 14:13:55 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Add support for FDP devices in fabrics passthru
 path
Message-ID: <20250716084301.aulmx23rmumae3ba@green245.gost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250715080958.GA20790@lst.de>
X-CMS-MailID: 20250716084412epcas5p4c412b3a6b918366d7548c3c97e772ad6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com>
	<20250715061804.1954522-1-nj.shetty@samsung.com>
	<20250715080958.GA20790@lst.de>

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/07/25 10:09AM, Christoph Hellwig wrote:
>On Tue, Jul 15, 2025 at 11:48:04AM +0530, Nitesh Shetty wrote:
>> In nvmet passthru path FDP is disabled, because of failure of
>> admin_get_features FDP(0x1d) feature command.
>> Supporting this through nvmet_setup_passthru_command enables FDP.
>
>I don't think this is safe - the feature has endurance group scope
>and thus can affect other controllers not passed through as well.
>
Agree, how about only enabling only for nvme_admin_get_features,
but not for nvme_admin_set_features, something like below?

--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -533,6 +533,8 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
  		case NVME_FEAT_HOST_ID:
  			req->execute = nvmet_execute_get_features;
  			return NVME_SC_SUCCESS;
+		case NVME_FEAT_FDP:
+			return nvmet_setup_passthru_command(req);
  		default:
  			return nvmet_passthru_get_set_features(req);
  		}

Thanks,
Nitesh

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_
Content-Type: text/plain; charset="utf-8"


------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_--

