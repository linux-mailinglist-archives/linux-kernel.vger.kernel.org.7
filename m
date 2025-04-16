Return-Path: <linux-kernel+bounces-602322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E1A87952
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE25D16DEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6723BCFF;
	Mon, 14 Apr 2025 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyGMOaWJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752B1A3169
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616685; cv=none; b=NlCquk46/I7TrxgLOwVK31CZLxydb0ap5V5Vn9DFf1mw56+vKpB6IuN1a/3kQHWH8gFFo4Cr7UXQqxT2g/CoPBteKHEJ8mBuGc5qMbjLXyTjVP8jm18wyjJ9ODCSJmQW+D6E8LuhIFQuE9vHYcBoxGEwfg2kYE40KM62gVRvE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616685; c=relaxed/simple;
	bh=KdQUGToJwrkWaTJ4EhYzTQ6O7+/0utyJXQUiWotxAWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ1Jkuk1NJ/YAlA/nHvPerUJmLGIZPFF/YhvTHQtTnaEpV7UvgskLdsk6/aLBB0FYcHBsMQBT7VhLO+7T63PpreO42wn44r7u6WnXJ3HubOAqDrfd9dbVlcBBGi9fyM3nq+eyOvJsKcGxAsQHmYgrufmvGfgytz6oqYS2SCiwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyGMOaWJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DLr3FP006843
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 07:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=amtLfqS20UyGP3/aF+w9heer
	yr5MJX9hjD6jnXN4jyI=; b=QyGMOaWJS0QuOba9/Ox0odoavdtIGqiQnQzU+/Ou
	6JFl8vqHLq5gYTooiSEivK1BAWESV5UiFJhjiYdQHZMgKjZu59IqT/0WzM9tqCtO
	KpbQFbg6KUXDarunl8gSB8Cyg1frKO5ueGIfSbxb2h3i2KdGeAXLTu7BCoBJYa3j
	lcfpUx1SK78i8P/LL6GwqsN/cQ3ftJ0NS8Mzfv57yF8QJOLVF7dZKcvQo7x132Hw
	IjS9a3WDi1o/LoRkou83WUfFb+16AnzBFeXsrTx2iytxlup8gaqUwRxU2Gj33v+7
	Tz55BP72adc//GmVUw8ZBiD2haUBZr5Cgeky5LqaZaoimA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69ksae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 07:44:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6eb2480028cso68814336d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 00:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744616681; x=1745221481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amtLfqS20UyGP3/aF+w9heeryr5MJX9hjD6jnXN4jyI=;
        b=NMAzBqvh1w7q+aPBxh8OWWyC6t5y4cAu7K+GL4852hHWars77FXPifAYICYHIQ+SiW
         I0LspZ50le2iNI/s0AlvEnd1Ug0eKTo5FiTLuzldw2dvuKvByUe6RRmZx+Agb9GcwM0R
         CT51pJtl1vRkJUemcqRNYO7VxT9kARC5mlrT8kDJxNfGSY+5vi77lvBQqOFwcBGcxxu7
         aI6JvFI45kuazMxo/LIL5nAC083u+6B2G0RTUeqnzKMYgjFFYEWzF0CSC4U6/oCgHu5W
         lCBsD6TVQ+W1KzWOXeV3/FVttizWuxw9nirEwdLh5TMq63BajPcWoZbFjnjWcZk2bqGe
         X/XA==
X-Forwarded-Encrypted: i=1; AJvYcCXHa2FbPhtjhSq+U3AeYn+KbEuR7LJy9eHA4f1ULl4PQqBrQ36JnmffThV0kVL9e4BKSkOWCiRUYI9JYqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN65ytWhENn5O3jLXYDyIJjrjL42v3feCgIPAI3S4Wq9a2vz6k
	yTB5M6xeL/TsKdiUhgiTdD7R5+DMoWjsB/GBMq+H3tUcwIS8GnNjJ5N/oC1ssKtbgAPvJpCxMJM
	rVOjJeqqHoJZrxefIWO28JqmbPtTAcPGFpZ9MKTyfLNx6TTerc7w5YzDKniWuKoQ=
X-Gm-Gg: ASbGncto8F5+VmZtvmfTF0I1f74ra5GGpP2GB+fyKfaRCwoWtf1QEzbWp11Naw7jFrr
	4T3qh4R5LrYErOmFlZhT1D/UOc3ekT3XYRXWPtiVfyiRtZufp16jZSiFtv3lmFNfkmWVG2lyV7o
	Nke+HRJn1FLqR5A+N2pKQ2/CPsG7fGBkDUDweY4RDJafOoLfKnJuT5KY0pGwqkjIy6g9o8koIYt
	Yf9Q/EDm6rGoiiYvU7hTLkyC89RAUV3b8fQwSSwK7fayzypCN4F5AqACmOQhLnb9uCqcWoTFo0H
	xhjeRkuZrOtqbZp8gIfC9yaTvLCYuasSQkfpll0SxTgFuZv5jYDNHK/2L7dfP0reJNHw7ZlkBbA
	=
X-Received: by 2002:a05:6214:23c5:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6f230d92f8cmr176297256d6.25.1744616680751;
        Mon, 14 Apr 2025 00:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4wGQzwGXF9t5mERNA8FQ+RoATEaIeTO5j1fILGHo04LQxp4vPBDrtkY6+CrcYd6j3fXQGAA==
X-Received: by 2002:a05:6214:23c5:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6f230d92f8cmr176296976d6.25.1744616680191;
        Mon, 14 Apr 2025 00:44:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d81dsm16322471fa.2.2025.04.14.00.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 00:44:39 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:44:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, quic_dsi@quicinc.com,
        Greg KH <gregkh@linuxfoundation.org>, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v1 4/4] misc: fastrpc: Add debugfs support for fastrpc
Message-ID: <wnsfo3oh2drieswureetgqw4kd3u7vth7lql2crttiu5znq7q7@uaing33r7efq>
References: <20241118084046.3201290-1-quic_ekangupt@quicinc.com>
 <20241118084046.3201290-5-quic_ekangupt@quicinc.com>
 <2024111804-doze-reflected-0feb@gregkh>
 <c3b285b0-33d1-4bfa-b8ab-6783ff5ed78d@quicinc.com>
 <cn7pqvhw4x4y7s5hbgzjpvyjnw4g6hoyepic4jai7x2fjdenxr@ikr4hkorbuwb>
 <365c4709-b421-4af8-b521-a195630242de@quicinc.com>
 <nsaq3zungvyhuikz35arvxmle2fovxh422jpyqxuleh57ufqnk@bekeh7qr7y76>
 <697e90db-6ecc-44ac-af86-6c7f910fc902@quicinc.com>
 <CAA8EJppbptPryu_O3G3YAapHT=Ai+MAdA38FtSU=YvWb+mqa1g@mail.gmail.com>
 <e1c23027-94c3-4fdf-b842-b154179aa2b8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c23027-94c3-4fdf-b842-b154179aa2b8@oss.qualcomm.com>
X-Proofpoint-GUID: grLpWBHMZJW4FS7O87dS0H9f0-pTEDsW
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fcbce9 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=05C-0vp_eMJKYO2ljG8A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: grLpWBHMZJW4FS7O87dS0H9f0-pTEDsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140054

On Fri, Apr 11, 2025 at 01:55:12PM +0530, Ekansh Gupta wrote:
> 
> 
> On 12/3/2024 5:27 PM, Dmitry Baryshkov wrote:
> > On Tue, 3 Dec 2024 at 07:22, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
> >>
> >>
> >> On 12/2/2024 6:18 PM, Dmitry Baryshkov wrote:
> >>> On Mon, Dec 02, 2024 at 03:27:43PM +0530, Ekansh Gupta wrote:
> >>>> On 11/22/2024 12:23 AM, Dmitry Baryshkov wrote:
> >>>>> On Thu, Nov 21, 2024 at 12:12:17PM +0530, Ekansh Gupta wrote:
> >>>>>> On 11/18/2024 7:32 PM, Greg KH wrote:
> >>>>>>> On Mon, Nov 18, 2024 at 02:10:46PM +0530, Ekansh Gupta wrote:
> >>>>>>>> Add changes to support debugfs. The fastrpc directory will be
> >>>>>>>> created which will carry debugfs files for all fastrpc processes.
> >>>>>>>> The information of fastrpc user and channel contexts are getting
> >>>>>>>> captured as part of this change.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/misc/fastrpc/Makefile        |   3 +-
> >>>>>>>>  drivers/misc/fastrpc/fastrpc_debug.c | 156 +++++++++++++++++++++++++++
> >>>>>>>>  drivers/misc/fastrpc/fastrpc_debug.h |  31 ++++++
> >>>>>>>>  drivers/misc/fastrpc/fastrpc_main.c  |  18 +++-
> >>>>>>>>  4 files changed, 205 insertions(+), 3 deletions(-)
> >>>>>>>>  create mode 100644 drivers/misc/fastrpc/fastrpc_debug.c
> >>>>>>>>  create mode 100644 drivers/misc/fastrpc/fastrpc_debug.h
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/misc/fastrpc/Makefile b/drivers/misc/fastrpc/Makefile
> >>>>>>>> index 020d30789a80..4ff6b64166ae 100644
> >>>>>>>> --- a/drivers/misc/fastrpc/Makefile
> >>>>>>>> +++ b/drivers/misc/fastrpc/Makefile
> >>>>>>>> @@ -1,3 +1,4 @@
> >>>>>>>>  # SPDX-License-Identifier: GPL-2.0
> >>>>>>>>  obj-$(CONFIG_QCOM_FASTRPC)      += fastrpc.o
> >>>>>>>> -fastrpc-objs    := fastrpc_main.o
> >>>>>>>> \ No newline at end of file
> >>>>>>>> +fastrpc-objs    := fastrpc_main.o \
> >>>>>>>> +                fastrpc_debug.o
> >>>>>>> Only build this file if debugfs is enabled.
> >>>>>>>
> >>>>>>> And again, "debug.c"?
> >>>>>> I'll add change to build this only if debugfs is enabled. Going forward I have plans to add
> >>>>>> few more debug specific changes, maybe then I'll need to change the build rules again.
> >>>>>>>> diff --git a/drivers/misc/fastrpc/fastrpc_debug.c b/drivers/misc/fastrpc/fastrpc_debug.c
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..cdb4fc6845a8
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/drivers/misc/fastrpc/fastrpc_debug.c
> >>>>>>>> @@ -0,0 +1,156 @@
> >>>>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>>>> +// Copyright (c) 2024 Qualcomm Innovation Center.
> >>>>>>>> +
> >>>>>>>> +#include <linux/debugfs.h>
> >>>>>>>> +#include <linux/seq_file.h>
> >>>>>>>> +#include "fastrpc_shared.h"
> >>>>>>>> +#include "fastrpc_debug.h"
> >>>>>>>> +
> >>>>>>>> +#ifdef CONFIG_DEBUG_FS
> >>>>>>> Please put the #ifdef in the .h file, not in the .c file.
> >>>>>> Ack
> >>>>>>>> +void fastrpc_create_user_debugfs(struct fastrpc_user *fl)
> >>>>>>>> +{
> >>>>>>>> +        char cur_comm[TASK_COMM_LEN];
> >>>>>>>> +        int domain_id, size;
> >>>>>>>> +        char *debugfs_buf;
> >>>>>>>> +        struct dentry *debugfs_dir = fl->cctx->debugfs_dir;
> >>>>>>>> +
> >>>>>>>> +        memcpy(cur_comm, current->comm, TASK_COMM_LEN);
> >>>>>>>> +        cur_comm[TASK_COMM_LEN-1] = '\0';
> >>>>>>>> +        if (debugfs_dir != NULL) {
> >>>>>>>> +                domain_id = fl->cctx->domain_id;
> >>>>>>>> +                size = snprintf(NULL, 0, "%.10s_%d_%d_%d", cur_comm,
> >>>>>>>> +                                current->pid, fl->tgid, domain_id) + 1;
> >>>>>>>> +                debugfs_buf = kzalloc(size, GFP_KERNEL);
> >>>>>>>> +                if (debugfs_buf == NULL)
> >>>>>>>> +                        return;
> >>>>>>>> +                /*
> >>>>>>>> +                 * Use HLOS process name, HLOS PID, fastrpc user TGID,
> >>>>>>>> +                 * domain_id in debugfs filename to create unique file name
> >>>>>>>> +                 */
> >>>>>>>> +                snprintf(debugfs_buf, size, "%.10s_%d_%d_%d",
> >>>>>>>> +                        cur_comm, current->pid, fl->tgid, domain_id);
> >>>>>>>> +                fl->debugfs_file = debugfs_create_file(debugfs_buf, 0644,
> >>>>>>>> +                                debugfs_dir, fl, &fastrpc_debugfs_fops);
> >>>>>>> Why are you saving the debugfs file?  What do you need to do with it
> >>>>>>> that you can't just delete the whole directory, or look up the name
> >>>>>>> again in the future when removing it?
> >>>>>> fl structure is specific to a process using fastrpc driver. The reason to save
> >>>>>> this debugfs file is to delete is when the process releases fastrpc device.
> >>>>>> If the file is not deleted, it might flood multiple files in debugfs directory.
> >>>>>>
> >>>>>> As part of this change, only the file that is getting created by a process is
> >>>>>> getting removed when process is releasing device and I don't think we
> >>>>>> can clean up the whole directory at this point.
> >>>>> My 2c: it might be better to create a single file that conains
> >>>>> information for all the processes instead of that. Or use fdinfo data to
> >>>>> export process / FD information to userspace.
> >>>> Thanks for your review. The reason of not having single file for all processes is that
> >>>> I can run 100s of iteration for any process(say calculator) and every time the properties
> >>>> of the process can differ(like buffer, session etc.). For this reason, I'm creating and
> >>>> deleting the debugfs files for every process run.
> >>>>
> >>>> Do you see any advantage of using fdinfo over debugfs? I'm not sure if we can add all
> >>>> the information(like in debugfs) here.
> >>> Which information is actually useful / interesting for application
> >>> developers? If not for the fdinfo, I might still vote for a single file
> >>> rather than a pile of per-process data.
> >> I have tried to capture all the information that could be useful.
> >>
> >> I can try changes to maintain single file for all active processes. Having this file specific
> >> to a channel should be fine, right? like fastrpc_adsp, fastrpc_cdsp, etc.? Each file will
> >> carry information of all processes using that remoteproc.
> > I think it's a better idea, yes.
> 
> Hi all,
> 
> I'm adding Deepika <quic_dsi@quicinc.com> to this thread who is reworking
> on this patch series.

Please don't do this in future. Corresponding engineer can download the
mbox of the thread from lore.kernel.org, import it into the email client
and respond directly, without extra emails.

-- 
With best wishes
Dmitry

