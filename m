Return-Path: <linux-kernel+bounces-729005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C0B03075
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B9B3B4AA2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C399F2206BB;
	Sun, 13 Jul 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyoYSocU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A3199938
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399002; cv=none; b=HnwMWZN0pQrpt5xyH6x8JoVzJp6TH82pvHRaJMiDYSDJL6Y6wl8TyskKNO25/NGiuYgaj585ArSFiNyDcaF+Uguw/4ZFdI8zkSI662r7+/ZbWsC1pdzWPqLjNdRmHuwRJjrE/6I9UPlkBiwnRGjL4/ECyCxoi9pvAjMAorrkZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399002; c=relaxed/simple;
	bh=jjmujOfz0YByvx6u1HvyFte3TNGEBmIAN0WgYDdBKpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7EDl+ZQGHkttFPN1ViW9cANUHmiGvGXo+geZYYrehS62WfxnKA/rED2ZqUN4vs+CT8DW2JLrd8zRkjrtJ8ym25r65qHHN0RLKgoGqBHRvVB+cwtGV2jrSqXp6edXa/9ezSqmJR8VRQf15imp8ALXioYCBbuI6hGaxOrvb2uILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TyoYSocU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56D99oKP014436
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dY6ZVa9DM+PzibcCkmZyv4ANviQi7JtP2IKQ1ChPXI=; b=TyoYSocUDSrD4s2V
	SUUkUAUj9OQ57WwvpnU19IBRKVuNeLTs2qZIpG0dlJffa0NxTofZuIXxNeO6f4dX
	Z0lhELhldHGttZfnbRiy/yk9ekfykahZAE/TYmpYoOee/mGI5qNJAiv2+dap+IH2
	PpXoGsLY+JLEERXtWjThY6RtwPqs+OzcMhvEkUz1G82No2cUbQQF24vakbhthatQ
	k/8lMbJR2l1glJ+WjNYCu9NoSpuXVdf57Ve7gn9mDsNwQUPYKpt3jRpEap8gNflk
	lTwhMjk26eEBpHO2QKC+QbxgJ6hDlDGbL8qtbVSh/UrTrRfQYvOG76Ud06J6lEHx
	t0AJUw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut1ubu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:29:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74913385dd8so5008352b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752398997; x=1753003797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dY6ZVa9DM+PzibcCkmZyv4ANviQi7JtP2IKQ1ChPXI=;
        b=Kz8gVKEiiM7AnYGaS6VBvsjIgTuGTtPGEOwiAnt76NT8iu6Eq3ulDgsXnWw5cQoPIr
         1pmkEjSobkidqQC+Pa4ZEYywXhHZBPJbADGMAVCdtohZSwT2btm2XqyjYNP5LPMU/Mfm
         31oaJ/R1JnX5zltB2d9pBBMHvOAYVlV9uaEZLBNELkjVvM1XFFy3Pb/WsyKDC2RdmZMQ
         GGIqGgGh4vBOJwJVJQ+2jhurOH639JdKRcBVmuqbT+6G46BOGlBCA6zC6V9h+He5G510
         ZF5WWimjzH1+nIsIGnqk7bUzki88cFHOzr1tlWYdlrmuq8XMOuOifhgRk23isc04v53m
         CTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc92ZAuYmWR5CsiWyctGO2tL+KyzRIUrwLxC6S5K0rl0L9L+xwvUmqeNkyu32kwaxr43ACFY0rQbCbIxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9zVl5sWN2b4TdpHu0Cn/XlzrtFtq+3nx4Y+plpWZ5gbXcFU+
	7E+/UNMxQIMVA6JnNp6Y27qyxZ9Eb2q0L2lh8CHqCAleSCMOrkkBaHAVrmwC3POlLIQ0o4qXZY+
	a/OgST262hu7O4rB0tUZmF1a2Qg7trY3bmW+k2hciC1oyvJKexOR9obliVaEcdQzdOjY=
X-Gm-Gg: ASbGnctgDTR0RQxx0gRDaPrzQMzvziPWR+I/pHPylBmNplr1hq1dZS4Ej4FC0hJPNBp
	okvQotN1vJnU3BOUVF0FRiQO+HQ1ezndGkhuM4jFkv4oW7CO4jw88syy6TyivVvrHd4pVjqeoVj
	/I7cZfdI7f11YaMPYplLI42BbpA6v9MyrqIVsic1QO514AkA8Jiq3rTtvPixIUzOtN0EfGB+v5w
	tl+kZvr9e/7wxlsnlA/Oor0Mn5RIi7R0Pc9aMcXonbh7yhcLKU0C5Bl3zUwhDcbum0X/cKBrmnM
	YmfbJByXp5hcyxi1I2rrei4pFFBmQltHbzOe/FQ8bO84ecskn2XGfXAWyEyGaOiDVIF84ci9WnR
	C6SxTlUjKjpyzSIkh7sW2IDY9JoO4YcAhLn7RCw==
X-Received: by 2002:a05:6a00:2352:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-74ee04ade9cmr14364987b3a.4.1752398996767;
        Sun, 13 Jul 2025 02:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz2YfpMT3tzMVZtVk/aJfp5mnzyvhKOdjKfF3sS31t6p0qgfYXHXVFuYF2XRE2ePI/Wi61RA==
X-Received: by 2002:a05:6a00:2352:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-74ee04ade9cmr14364955b3a.4.1752398996212;
        Sun, 13 Jul 2025 02:29:56 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb1:5cc8:5574:6ccf:b356:9c65? ([2401:4900:1cb1:5cc8:5574:6ccf:b356:9c65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f949adsm8742795b3a.174.2025.07.13.02.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 02:29:55 -0700 (PDT)
Message-ID: <27ff2c46-9402-47e6-b5ea-8a1f783220b1@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 14:59:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] usb: dwc3: qcom: Implement glue callbacks to
 facilitate runtime suspend
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com>
 <20250610091357.2983085-3-krishna.kurapati@oss.qualcomm.com>
 <20250623233211.aeehndz2nxqovepd@synopsys.com>
 <a46b9870-207b-45a1-b3e6-5c13e1857640@oss.qualcomm.com>
 <20250711232929.5oukafed5lnvsu2v@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20250711232929.5oukafed5lnvsu2v@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68737c96 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=O1qQoxS_gdKAj5MKBqMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: c5vJdN8nkOVBzqc7wkqNRfY4mm_VmXi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDA2NCBTYWx0ZWRfXwnFEgU3bnX7J
 4x3gVrE+qyWNiwOep/C58+c39AfRHZbzbHArcPWgifHl4LQcTEmifKtUKnQsTFoyjVHbG2o8SbG
 cZx5DUTh+Mrh49v7n+P1Gwfwxw79Fl1/gfk64RLH7l9PQoGV/lGdlHGlOTnFK4S2Cny/e2z29WL
 eFhXdwiVVg8Z4gbA3KvW+nb4P2QDgs4LuiM1J/Vo7O4DlVtLhIRWMsxB5aAnePFdbXfSFLTXqab
 I5DCYLyd7FiMkZa78vJeIF/tFfITuyws4sn3ihZOLT4TO5XLD8kJ4r84fmsddvHMdg9lwzaXn1V
 UmRXTmYOh4ueBdTTvejLSaoTk33K9lVPpDcNPk2LbiaqcawPjDoCK6uEKTZJE1HyY7bGLdoP33U
 JKfwtiwNw05YB4qatfB652dQjx8J8DgkIx3+NSj1CJxf5vntYpcHdRbnr+BWvzANZIdR26Oz
X-Proofpoint-ORIG-GUID: c5vJdN8nkOVBzqc7wkqNRfY4mm_VmXi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507130064



On 7/12/2025 4:59 AM, Thinh Nguyen wrote:
> On Tue, Jun 24, 2025, Krishna Kurapati wrote:
>>
>>
>> On 6/24/2025 5:02 AM, Thinh Nguyen wrote:
>>> On Tue, Jun 10, 2025, Krishna Kurapati wrote:
>>>> On Qualcomm DWC3 dual-role controllers, the conndone/disconnect events in
>>>> device mode are generated by controller when software writes to QSCRATCH
>>>> registers in Qualcomm Glue layer rather than the vbus line being routed to
>>>> dwc3 core IP for it to recognize and generate these events.
>>>>
>>>> UTMI_OTG_VBUS_VALID  bit of QSCRATCH_HS_PHY_CTRL register needs to be set
>>>> to generate a connection done event and to be cleared for the controller to
>>>> generate a disconnect event during cable removal. When the disconnect is
>>>> not generated upon cable removal, the "connected" flag of dwc3 is left
>>>> marked as "true" and it blocks suspend routines and for that to happen upon
>>>> cable removal, the cable disconnect notification coming in via set_role
>>>> call need to be provided to the Qualcomm glue layer as well.
>>>>
>>>> Currently, the way DWC3 core and Qualcomm legacy glue driver are designed,
>>>> there is no mechanism through which the DWC3 core can notify the Qualcomm
>>>> glue layer of any role changes which it receives via role switch. To
>>>> register these glue callbacks at probe time, for enabling core to notify
>>>> glue layer, the legacy Qualcomm driver has no way to find out when the
>>>> child driver probe was successful since it does not check for the same
>>>> during of_platform_populate.
>>>>
>>>> Hence implement the following glue callbacks for flattened Qualcomm glue
>>>> driver:
>>>>
>>>> 1. set_role: To pass role switching information from drd layer to glue.
>>>> This information is needed to identify NONE/DEVICE mode switch and modify
>>>> QSCRATCH to generate connect-done event on device mode entry and disconnect
>>>> event on cable removal in device mode.
>>>>
>>>> 2. run_stop: When booting up in device mode, if autouspend is enabled and
>>>> userspace doesn't write UDC on boot, controller enters autosuspend. After
>>>> this, if the userspace writes to UDC in the future, run_stop notifier is
>>>> required to enable UTMI_OTG_VBUS_VALID of QSCRATCH so that connect done
>>>> event is generated after run_stop(1) is done to finish enumeration.
>>>>
>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>> ---
>>>>    drivers/usb/dwc3/dwc3-qcom.c | 82 ++++++++++++++++++++++++++++++++----
>>>>    1 file changed, 73 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>>>> index ca7e1c02773a..d40b52e2ba01 100644
>>>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>>>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>>>> @@ -89,6 +89,12 @@ struct dwc3_qcom {
>>>>    	bool			pm_suspended;
>>>>    	struct icc_path		*icc_path_ddr;
>>>>    	struct icc_path		*icc_path_apps;
>>>> +
>>>> +	/*
>>>> +	 * Current role changes via usb_role_switch_set_role callback protected
>>>> +	 * internally by mutex lock.
>>>> +	 */
>>>> +	enum usb_role		current_role;
>>>
>>> Can we just track the current role through dwc3 core instead of an
>>> addition field in the glue?
>>>
>>
>> Core caches only mode. We need ROLE NONE to identify cable connect. So
>> adding that in glue to keep track.
>>
> 
> The controller is always either host or device, not somewhere in
> between. You're using ROLE_NONE to indicate connection, which is a
> separate state.
> 

Yes, but there is no flag that indicates that in dwc structure today. 
Also since only dwc3-qcom needs it at the moment, I added that role info 
in glue layer.

> I feel this should be tracked separately for clarity. The dwc3 also
> tracks the connection state, can we use that?
> 

Are you referring to the "connected" flag in DWC structure ? I see that 
it indicates connection status only in gadget mode.

Regards,
Krishna,

