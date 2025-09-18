Return-Path: <linux-kernel+bounces-766743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D935BB24A95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D10C170B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F52E92D2;
	Wed, 13 Aug 2025 13:27:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1A2E8DEC;
	Wed, 13 Aug 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091663; cv=none; b=UrjxO7RYo4DRITdgQPYwtxbLZgIIX4VNzIHeJSlqzzAAyjGVLT/+B4uNpyQTk2Q9b4yZbVDuE2ys+EdyYZRw5BxlgnBvRwNtjFD140g6TyRUuqNAJNjwqYDV5aOo77WxXktZ35jk0gq/JI2QNdaZAZOtJQwWtLsDTAlU2dquhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091663; c=relaxed/simple;
	bh=hZ+JE4jGbjA/KNMe5aoqMKy1B/uVtqhNB2a2Nw+ZFkk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVyHHyUB/hZqKWrpFiqy5uf7YZ8Yg69o7bQdj3xxUOXWtSNRRfAZkoLwCFrsfZH7mvGQUJv5hL1Y1v055HOLFjXpYsxYBmoMIscFHdPSYgGkogx6Plt2F6t4jOeyrm/xo3FbPNpVoD4tnS95N/zPyfAaKNBs8VNuyCf8mHyDYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c28HZ4Wc5z6G957;
	Wed, 13 Aug 2025 21:24:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D64B1400D4;
	Wed, 13 Aug 2025 21:27:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 15:27:39 +0200
Date: Wed, 13 Aug 2025 14:27:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Neeraj Kumar <s.neeraj@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
	<a.manzanares@samsung.com>, <vishak.g@samsung.com>, <neeraj.kernel@gmail.com>
Subject: Re: [PATCH V2 03/20] nvdimm/namespace_label: Add namespace label
 changes as per CXL LSA v2.1
Message-ID: <20250813142737.00005b0f@huawei.com>
In-Reply-To: <20250730121209.303202-4-s.neeraj@samsung.com>
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121225epcas5p2742d108bd0c52c8d7d46b655892c5c19@epcas5p2.samsung.com>
	<20250730121209.303202-4-s.neeraj@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 17:41:52 +0530
Neeraj Kumar <s.neeraj@samsung.com> wrote:

> CXL 3.2 Spec mentions CXL LSA 2.1 Namespace Labels at section 9.13.2.5
> Modified __pmem_label_update function using setter functions to update
> namespace label as per CXL LSA 2.1
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>

> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 61348dee687d..651847f1bbf9 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -295,6 +295,33 @@ static inline const u8 *nsl_uuid_raw(struct nvdimm_drvdata *ndd,

> +static inline void nsl_set_alignment(struct nvdimm_drvdata *ndd,
> +				     struct nd_namespace_label *ns_label,
> +				     u32 align)
> +{
> +	if (ndd->cxl)
> +		ns_label->cxl.align = __cpu_to_le16(align);

The bot caught this one, it should be __cpu_to_le32(align);

> +}


