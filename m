Return-Path: <linux-kernel+bounces-590459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B0A7D334
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 06:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2DF188AFAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 04:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A13221F29;
	Mon,  7 Apr 2025 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tSrP+wtT"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33923C9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001926; cv=none; b=sMa1kyXPRaWi403IaYEYR3XGs0VKnAe4Ssxvjh5IagZq5FObV9ri0hFxV28ov8N4+2zS1spo+KHA4oXaWrgqmOPFMz4SPSwvCTp8ADQdrjEv/+C7sTOpwEH+ewZGEIQCFFXQcfhWeAl4e4DiKrE9CYpnnCKSGoFHQ3X+1GOvPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001926; c=relaxed/simple;
	bh=68edhrXLocuAQRlZApOPpmkxxqtQSZvJp5bNVe4SFcU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=eBRs+xcufsA5THGAja3y6t1IqFUUqGvRxI2c8JxG8GOFscdOLhhlnqFs4B//nOxcyUg0/wHjdc4D4lDKVbX5e7eXTXdtNOWe6M85q2FSSUnQFeS/iuAC/LJRralYg6+xyZwfxewEtlUbIZ6Oe2DdAyE0FJeWO0vVR/Tcu9aGiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tSrP+wtT; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250407045833epoutp0152032b91b6759538dc81b17163a84e7f~z8IAmsqds1072010720epoutp01F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 04:58:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250407045833epoutp0152032b91b6759538dc81b17163a84e7f~z8IAmsqds1072010720epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744001913;
	bh=03aOdAjUBDC8/qC+inuZ+ioqiRq9TMLbu0bgJhZgSB4=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=tSrP+wtTiMeqVAso3I3BmlmFShdicIKGB73o2mP04IoBoWtTo9AmsFH2UynaR2/jo
	 ra7FX8x1g0GApbeLlBR22h5URsAPY0c1++wGyn839RKUsX5vnt+2sOzUlh+zOr+qMJ
	 EqqVmFMyCc909iSsqartsuAZu93UoWO1F24Txb3s=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20250407045833epcas1p41a9cefd36a279d42c3f886a1e4cef34f~z8IAUaa6b2555925559epcas1p4g;
	Mon,  7 Apr 2025 04:58:33 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZWH6J6cX5z6B9mG; Mon,  7 Apr
	2025 04:58:32 +0000 (GMT)
X-AuditID: b6c32a38-d50fc700000029f0-3a-67f35b7851c3
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.3F.10736.87B53F76; Mon,  7 Apr 2025 13:58:32 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH 1/4] extcon: adc-jack: Fix wakeup source leaks on device
 unbind
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi
	<cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai
	<wens@csie.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250406-device-wakeup-leak-extcon-v1-1-8873eca57465@linaro.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250407045832epcms1p7956a6ce5af6d2f8cca6169a68fd7bf31@epcms1p7>
Date: Mon, 07 Apr 2025 13:58:32 +0900
X-CMS-MailID: 20250407045832epcms1p7956a6ce5af6d2f8cca6169a68fd7bf31
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmrm5F9Od0g+lrTC2uf3nOavHm+HQm
	i72vt7JbTNx/lt3i8q45bBY/D51ncmDz2PBoNavHnWt72Dze77vK5tG3ZRWjx+dNcgGsUdk2
	GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKCmUJeaU
	AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM/5d
	ucZacImtYu6KK2wNjE9Yuxg5OCQETCROdwd0MXJxCAnsYJRYu/0dO0icV0BQ4u8O4S5GTg5h
	gVCJvoltrCC2kICSRMPNfcwQcX2JjgfbGEFsNgFdia0b7rKAzBERWMoo8f7tbFYQh1mghVHi
	y74dTCBVEgK8EjPan7JA2NIS25dvBevmFPCTONI0hw0iLipxc/Vbdhj7/bH5jBC2iETrvbPM
	ELagxIOfu6HikhKfXrQzgiyTEJjNKPG9dzYzhLOZUeLH5Z9Q28wlWo9vBJvKK+Ar0d9/Dqyb
	RUBV4mzDVVaIGheJfSe2g21gFpCX2P52DjMoKJgFNCXW79KHCPNJvPvawwrzzI55T6AeU5M4
	tHsJ1NEyEqenL4Q61EOiZx/IY6Dgvckosej9I+YJjPKzECE8C8m2WQjbFjAyr2IUSy0ozk1P
	LTYsMIHHaXJ+7iZGcBrUstjBOPftB71DjEwcjIcYJTiYlUR4LU99ShfiTUmsrEotyo8vKs1J
	LT7EaAr050RmKdHkfGAiziuJNzSxNDAxMzI2sTA0M1QS59398Wm6kEB6YklqdmpqQWoRTB8T
	B6dUA1No7LV3geZ/iqpjrIR3r+ianykhJr9SK1NsnYPV0dnt380XymXIl+x/oV3zsIMtl90o
	3Jb11yeZt20TnvP4sE3+9PT4xz3KOxbwTjS6fEFOegF3srZYk/TEue5lJ7hi5n1Xu/bZ58WD
	7hyWq0XWu2Sm917d+fK8pX7LtkmmeznM7i9gNjbP6pzGlrPm97dgx19HA43+BpdGJMtd+vjg
	R2f03LJ/Sd9MnzZ82Kpdrz/97Pyadjk9pzniuSpM8W3OK+VrxE8UcaR+W/1Med6mPO4DjzOs
	5+UmzHvMpKN7PFV7mS/HhBvTHFw1K58Vam7l4GxJumsZZJJ+4noIY+vd8MtX/Hasnpu9Xfrp
	xUcZKkosxRmJhlrMRcWJAHnX+H0MBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250406201656epcas1p4fc1bbf95a05fff2945fbc9b53ca21a9b
References: <20250406-device-wakeup-leak-extcon-v1-1-8873eca57465@linaro.org>
	<20250406-device-wakeup-leak-extcon-v1-0-8873eca57465@linaro.org>
	<CGME20250406201656epcas1p4fc1bbf95a05fff2945fbc9b53ca21a9b@epcms1p7>

>Device can be unbound, so driver must also release memory for the wakeup
>source.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
> drivers/extcon/extcon-adc-jack.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
>index 46c40d85c2ac89599ffbe7b6d11b161b295d5564..d7e4b1418d7e6b242780b3511f2a49def3acb7a6 100644
>--- a/drivers/extcon/extcon-adc-jack.c
>+++ b/drivers/extcon/extcon-adc-jack.c
>@@ -164,6 +164,7 @@ static void adc_jack_remove(struct platform_device *pdev)
> {
> 	struct adc_jack_data *data = platform_get_drvdata(pdev);
> 
>+	device_init_wakeup(&pdev->dev, 0);
> 	free_irq(data->irq, data);
> 	cancel_work_sync(&data->handler.work);
> }

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo

