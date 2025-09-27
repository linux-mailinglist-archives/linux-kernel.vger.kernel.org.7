Return-Path: <linux-kernel+bounces-834695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8319BA54B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A441C02B44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4129A310;
	Fri, 26 Sep 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cIzTOVac"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF628D83E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924443; cv=none; b=d0gsGlnea4weLyI6IXHISr4WquGh8F/W0rd1sZ2y82cApk6Ldzj9CY2LGe6cKxcFSyYpBoqAdjOTAM6fHhJ1JlOmNm5q9Jo/cTstH+tvleVhvrKO28PTADGa95mQUpaB2m3r62Zot4Lu15y3oQg42N6UCK8wl9sWFPI6xVt/U10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924443; c=relaxed/simple;
	bh=BV1ZxDHMWxY38fQkwL5M+vOanIM66s2UNwhIQ9cEvbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU0+uJYMXwKXulC3fMQ2prF+IOvhGRGw+B5ww10d8VYQp2A/8MYqXIZ038CBV+QBhoAZqf+/w0ktijhA4gKx5t90aE0AoO8lxHHPARgX+cn8L0Dc7z1n2rUbHPy0LnIcMM3zL8ti4JK6ZpHZVDdgkhaNKVFiM6Neu2BNzb7t+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cIzTOVac; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWovh015940
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lHtAHBnJANbRMtBfR2vxVJaV
	VRDR9+GfMMa3SXU9+WQ=; b=cIzTOVacqywUe94nbfMHFrTcCGghBqY+QdouA70B
	8JE55/BAUndTR85COcseST3y0UhmeG/BUmxYf2+En06Tq4n7xrdyUrWsywJ45qqM
	9w3JUJaUBIp9JWWN6uOod3aGGVWm+1AXOVG2msHITPJzr9qSv0Usak/6G0QaqJZC
	lbP8u+ZRQOQcS/zABwhZsMIIP7KIjkzU44J/AGUYZKJXss8Iy2IoEeYjhw+fyZ47
	QSWXGCPO4O1t0/d1f1BhUizsj+/DiKviS2Lfxkdb3sCQHaGVHdraEJmASQzk+FOp
	uTN/U54NHMN9QQFwssWS98wxuqjVLIwjTT2e646blJtcZA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0tv95x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:07:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df22892603so429821cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924439; x=1759529239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHtAHBnJANbRMtBfR2vxVJaVVRDR9+GfMMa3SXU9+WQ=;
        b=fHhX6OGXaAeMcN9k5e0uPgWnE7wYJ6fe/0YArWhwkYCuGb0V/gXfG5xWArLfpX9Wnq
         J3U5iqDMwpE6Q+kYa6DTDh4OXq6VhwCYdODVAt1DivK25PvwCSEEaQJ1jnAQX40CyNRM
         mgtxSLdF2HlPBl9PiDNlVStyQFqIp1492L/zdAzzEBQzfvg6w8EIRdmZOXxcnMf9bw4J
         7rctv3IJ2yd3UutUUvNKwkEjzpFtMJThnAJ21Pf+Kqbld9h+3H1j3ZVBfzU0Xp20+605
         quB8gFImlJ1rFbKZvJGJhM0iKyFZmpOL1ZPM00u45a9xuO0FFTEnxnJ9zQEEGNUjWMX8
         mJyw==
X-Forwarded-Encrypted: i=1; AJvYcCVHpW+ZufA+SfQJ2BCxSrGPAL1111yBhSRNf7CkOX7tsVKDNRIbZASmiSTWd6LZX1dFAa/4HhHn/7nnC2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9d0R4FaogyO8Unnl/vIci4PaHYErJ8NXT09Zw15nT4psQTOjf
	sMwfPFQgf4ZFpAEnczcvucbWBsJyI5VlmNAKb72Pdxnkuz030Y/7t8KJuIjK1DOqlUeoMVilZpR
	4SA9HLkCyqsOJ5cHjQDeS7dOGipQzlrwpzmPSNQfPlw+0oCsOQMeoeakn6xisAQUBL90=
X-Gm-Gg: ASbGncua0wL3QPQLi/K7ccz7Pq5TDminF6b56yHAM1CQulM1D/HqpiikX3pUfGIZKnn
	KsjA2T2xbIJSouZeOhEK+f/q9VXC2Ucyxk5Fo2Gxd7Hfu68KOP8QChO/XfkXn5jDactbHccll+w
	SqE0p1elYTmpV3LnPAbVno+nnZVIfu22hn6levv0ppuxShGZHHTshb4yHZDAFgY962EXR5NX2yr
	XREkexTb3sXvLVWd8POYqjJOrqSmKLXd3cuiJvYsGYuGp70TOt5LYRn5iIHmfmU4VHzu/khf4E0
	mUi6b4TWptkzHS8URzxkDSKqZgDfvhFSDR5Zrknu3RgjUmIAT4UdLCRZsJr0Wcf7oGYQqo2YgN0
	U+j+JP7QRIViyw5Z5NIbS4VyGpzRdrNnoSYQFPGWMJK0JT0pGttHr
X-Received: by 2002:a05:622a:5e1a:b0:4da:7af7:ca1d with SMTP id d75a77b69052e-4da7b1654b9mr66755151cf.55.1758924439211;
        Fri, 26 Sep 2025 15:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7y9BPwYXsLwllrlICGh/y3wjajN0DatA1Xa1+K1MRg4+CJ6exu6kPOh8+ogzY0kvWFwS0xQ==
X-Received: by 2002:a05:622a:5e1a:b0:4da:7af7:ca1d with SMTP id d75a77b69052e-4da7b1654b9mr66754931cf.55.1758924438695;
        Fri, 26 Sep 2025 15:07:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583173d0fbfsm2141145e87.144.2025.09.26.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:07:16 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:07:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi_glink: Increase buffer size to
 support UCSI v2
Message-ID: <6kbkkiwsp3hzu2u6uezelwufooeeh7efrcc2buydpbziuhr5px@xdp24rhfjqyf>
References: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
 <20250924232631.644234-3-anjelique.melendez@oss.qualcomm.com>
 <t3hfr33t76ckecatro5gheycb2phnch57m6zzdpm44ibykbubd@e6nffasyetib>
 <4cbcf312-7697-4725-8fd8-45f2b5b0584f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbcf312-7697-4725-8fd8-45f2b5b0584f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d70e98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KvxZ8lf09URLfSDANNkA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 5_WXyygC4WrJA1mULvZ-yC11EnGYiqRD
X-Proofpoint-ORIG-GUID: 5_WXyygC4WrJA1mULvZ-yC11EnGYiqRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX9osqixvrfaoW
 v0iNNIF7zkYGKgzkqKxsSvQigM7HgYhhnqfif+ZbVKNfuv97P7Slmx6hRYDpVp9+WDpuhASK7wZ
 iUuF8y5TUIKBiVdPldRqWPiwfETBkektdxOEeRH6cbtQPG8CzOBKM7goiPA0FK1UgnmKSC5clqE
 ZDca4BeiAUfhMBFtj90OV2cbHMyJhcgww7BNhJk2pTA+uPSeUATrMPAB4xi1Z+Hr2YVw6BKOX2R
 gaY+JyhB0btTk8OcUubKleXRZSbhU6IVdXSoMJwDt5Qnh2CSyu00N3hSzVa6UVWISC+y77JePsX
 W44W04/03Vsp6A0xi0u5YCgnRNYGroD7CSj5Aml8p9gNpnrf0TQfPRBpmo53VtO8vHOyfVPgMdH
 48NSYKabfDfbGfNoeH3GQVEwNA6Zvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 11:19:13AM -0700, Anjelique Melendez wrote:
> 
> 
> On 9/25/2025 2:43 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 04:26:31PM -0700, Anjelique Melendez wrote:
> > > UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
> > > 16 bytes to 256 bytes each for the message exchange between OPM and PPM
> > > This makes the total buffer size increase from 48 bytes to 528 bytes.
> > > Update the buffer size to support this increase.
> > > 
> > > Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> > > ---
> > >   drivers/usb/typec/ucsi/ucsi_glink.c | 81 ++++++++++++++++++++++++-----
> > >   1 file changed, 68 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> > > index 1f9f0d942c1a..7f19b4d23fed 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> > > @@ -16,10 +16,10 @@
> > >   #define PMIC_GLINK_MAX_PORTS		3
> > > -#define UCSI_BUF_SIZE                   48
> > > +#define UCSI_BUF_V1_SIZE		(UCSI_MESSAGE_OUT + (UCSI_MESSAGE_OUT - UCSI_MESSAGE_IN))
> > > +#define UCSI_BUF_V2_SIZE		(UCSIv2_MESSAGE_OUT + (UCSIv2_MESSAGE_OUT - UCSI_MESSAGE_IN))
> > >   #define MSG_TYPE_REQ_RESP               1
> > > -#define UCSI_BUF_SIZE                   48
> > >   #define UC_NOTIFY_RECEIVER_UCSI         0x0
> > >   #define UC_UCSI_READ_BUF_REQ            0x11
> > > @@ -30,15 +30,27 @@ struct ucsi_read_buf_req_msg {
> > >   	struct pmic_glink_hdr   hdr;
> > >   };
> > > -struct __packed ucsi_read_buf_resp_msg {
> > > +struct __packed ucsi_v1_read_buf_resp_msg {
> > >   	struct pmic_glink_hdr   hdr;
> > > -	u8                      buf[UCSI_BUF_SIZE];
> > > +	u8                      buf[UCSI_BUF_V1_SIZE];
> > >   	u32                     ret_code;
> > >   };
> > > -struct __packed ucsi_write_buf_req_msg {
> > > +struct __packed ucsi_v2_read_buf_resp_msg {
> > >   	struct pmic_glink_hdr   hdr;
> > > -	u8                      buf[UCSI_BUF_SIZE];
> > > +	u8                      buf[UCSI_BUF_V2_SIZE];
> > > +	u32                     ret_code;
> > > +};
> > > +
> > > +struct __packed ucsi_v1_write_buf_req_msg {
> > > +	struct pmic_glink_hdr   hdr;
> > > +	u8                      buf[UCSI_BUF_V1_SIZE];
> > > +	u32                     reserved;
> > > +};
> > > +
> > > +struct __packed ucsi_v2_write_buf_req_msg {
> > > +	struct pmic_glink_hdr   hdr;
> > > +	u8                      buf[UCSI_BUF_V2_SIZE];
> > >   	u32                     reserved;
> > >   };
> > > @@ -72,7 +84,7 @@ struct pmic_glink_ucsi {
> > >   	bool ucsi_registered;
> > >   	bool pd_running;
> > > -	u8 read_buf[UCSI_BUF_SIZE];
> > > +	u8 read_buf[UCSI_BUF_V2_SIZE];
> > >   };
> > >   static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
> > > @@ -131,18 +143,34 @@ static int pmic_glink_ucsi_read_message_in(struct ucsi *ucsi, void *val, size_t
> > >   static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
> > >   					const void *val, size_t val_len)
> > >   {
> > > -	struct ucsi_write_buf_req_msg req = {};
> > > -	unsigned long left;
> > > +	struct ucsi_v2_write_buf_req_msg req = {};
> > > +	unsigned long left, max_buf_len;
> > > +	size_t req_len;
> > >   	int ret;
> > > +	memset(&req, 0, sizeof(req));
> > >   	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
> > >   	req.hdr.type = MSG_TYPE_REQ_RESP;
> > >   	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
> > > +
> > > +	if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
> > > +		req_len = sizeof(struct ucsi_v2_write_buf_req_msg);
> > > +		max_buf_len = UCSI_BUF_V2_SIZE;
> > 
> > I'd prefer it to be more explicit. Define an union of v1 and v2, fill
> > common parts and version-specific parts separately.
> Konrad also left a similar comment in this function "This code keeps the
> 'reserved' field zeored out for v1, but it does so in a fragile and implicit
> way :/" (https://lore.kernel.org/all/df671650-a5af-4453-a11d-e8e2a32bd1ab@oss.qualcomm.com/#t)
> 
> So I figured I would try to get thoughts from the both of you :)
> 
> We could have a union defined like so:
> struct __packed ucsi_write_buf_req_msg {
> 	struct pmic_glink_hdr   hdr;
> 	union {
> 		u8 v2_buf[UCSI_BUF_V2_SIZE];
> 		u8 v1_buf[UCSI_BUF_V1_SIZE];
> 	} buf;
> 	u32                     reserved;
> };

LGTM.

> 
> and then ucsi_locked_write() pseudo would be something like this:
> 
> pmic_glink_ucsi_locked_write()
> {
> 	struct ucsi_write_buf_req_msg req = {};
> 	u8 *buf;
> 
> 	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
> 	req.hdr.type = MSG_TYPE_REQ_RESP;
> 	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
> 
> 	if (version >= UCSI_VERSION_2_0)
> 		buf_len = UCSI_BUF_V2_SIZE;
> 		buf = req.buf.v2_buf;
> 	else if (version)
> 		buf_len = UCSI_BUF_V1_SIZE;
> 		buf = req.buf.v1_buf;
> 	else
> 		return -EINVAL;
> 	req_len = sizeof(struct pmic_glink_hdr) + buf_len + sizeof(u32);
> 
> 	memcpy(&buf[offset], val, val_len);
> 
> 	ret = pmic_glink_send(ucsi->client, &req, req_len);
> 	if (ret < 0)
> 		return ret;
> 
> 	left = wait_for_completion_timeout(&ucsi->write_ack, 5 * HZ);
> 	if (!left)
> 		return -ETIMEDOUT;
> 
> 	return 0;
> }
> 
> Since we are adding the union we still end up initializing space for the
> larger UCSI v2 buffer and when we have UCSI v1 we are only expected to send
> a request with buffer size = UCSI v1. With this we would still be keeping a
> reserved field zeroed for v1 but it still is not the req.reserved field
> being explicitly sent.
> 
> The only other solution I can think of that would be fully explicit is if we
> created pmic_glink_ucsi_v2_locked_write() which basically just did the exact
> same thing as the original pmic_glink_ucsi_locked_write() but instead used
> ucsi_v2_write_buf_req_msg struct. pmic_glink_ucsi_async_control() would then
> decide which locked_write function to call based on version. However that
> would include a lot of code copying.
> 
> Let me know what your thoughts are - I'm more than happy to go the way of
> the union but just want to make sure that we are all on same page and can
> agree on best steps forward :)
> 
> Thanks,
> Anjelique

-- 
With best wishes
Dmitry

