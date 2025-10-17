Return-Path: <linux-kernel+bounces-858283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60EBEA1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E77C1486
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE42F12C5;
	Fri, 17 Oct 2025 15:14:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C981D5CE0;
	Fri, 17 Oct 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714049; cv=none; b=EkYkJ/m+yANfQfpj9qpe/9E/V6R0VS6PubedK0qpvoIduAHhh5S/ffqyNskdFEiSJEXUGoYG7bMuUU34NffCBraQ56EXiW+IakgarHtHiODtH3GPofoxGaNFHm6WHrVQpSUyLPaWHJmJ5WCBuC++LB2zKQYsDGDCu9IJ7hkxXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714049; c=relaxed/simple;
	bh=GA/hkLmGZG/GJKmvuYn3DBpl49d8D7CUlR+0KQNvegs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVvLSYk7o9WgHM8ByV+BEvi/G5NnyxJLXeqaODh0E7u3rmaoiK3TLm9BRM/zkIOfYksznGfKgBqE6QzaMcXSdDdIgroyPLyggrfnktMepvzN8z+6f8Kvd9mn3UKNvA0TBbV1rjIoNlcVNqnG9YKAHX0mgPpUoMyQ/3PXvLXg7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp7c75Mc5z6K5Wg;
	Fri, 17 Oct 2025 23:12:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 20E0B1402FF;
	Fri, 17 Oct 2025 23:14:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 16:14:03 +0100
Date: Fri, 17 Oct 2025 16:14:01 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 04/10] uapi: Add ARM SCMI definitions
Message-ID: <20251017161401.00002891@huawei.com>
In-Reply-To: <20250925203554.482371-5-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-5-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 21:35:48 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add a number of structures and ioctls definitions used by the ARM
> SCMI Telemetry protocol.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Hi Cristian,

Main thing in here is request to add __counted_by markings for the flexible array members.

>  SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
> diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
> new file mode 100644
> index 000000000000..b1a6d34fee4a
> --- /dev/null
> +++ b/include/uapi/linux/scmi.h
> @@ -0,0 +1,286 @@

> +
> +/**
> + * scmi_tlm_config  - Whole instance or group configuration
> + *
> + * @enable: Enable/Disable Telemetry for the whole instance or the group
> + * @t_enable: Enable/Disable timestamping for all the DEs belonging to a group.
I'm fairly sure that even for reserved the kernel-doc script will complain if no
documentation.  (I haven't checked if it special cases that though!)
> + * @current_update_interval: Get/Set currently active update interval for the
> + *			     whole instance or a group.
> + *
> + * Used by:
> + *	RO - SCMI_TLM_GET_CFG
> + *	WO - SCMI_TLM_SET_CFG
> + *
> + * Supported by:
> + *	control/
> + *	groups/<N>/control
> + */
> +struct scmi_tlm_config {
> +	__u8 enable;
> +	__u8 t_enable;
> +	__u8 reserved[2];
> +	__u32 current_update_interval;
> +};

> +/**
> + * scmi_tlm_grps_list  - DE-groups List
> + *
> + * @num_grps: Number of entries returned in @grps
> + * @grps: An array containing descriptors for all defined DE Groups
> + *
> + * Used by:
> + *	RW - SCMI_TLM_GET_GRP_LIST
> + *
> + * Supported by:
> + *	control/
> + */
> +struct scmi_tlm_grps_list {
> +	__u32 num_grps;
> +	struct scmi_tlm_grp_info grps[];

As below on __counted_by

> +};
> +
> +/**
> + * scmi_tlm_grp_desc  - Group descriptor
> + *
> + * @num_des: Number of DEs part of this group
> + * @composing_des: An array containing the DE IDs that belongs to this group.
> + *
> + * Used by:
> + *	RW - SCMI_TLM_GET_GRP_DESC
> + *
> + * Supported by:
> + *	groups/<N>control/
> + */
> +struct scmi_tlm_grp_desc {
> +	__u32 num_des;
> +	__u32 composing_des[];

If we can give this a __counted_by marking please do.

> +};



