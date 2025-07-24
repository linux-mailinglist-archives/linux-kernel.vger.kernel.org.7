Return-Path: <linux-kernel+bounces-743688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D0B101E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296BA3B3130
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43826738D;
	Thu, 24 Jul 2025 07:31:30 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9119882B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342289; cv=none; b=lEgsikxgJb5ExECOoRF5WAWpkN1NUBVCuUvbkNsRIPC+4nqSRIzGByPPex9qWUMhzXXTM7kyvWVAw/u7tDfrZqj7zwWmZnvYkWGDbWoFXkuldRQDECSiK6vFOsF1IPsGXQQU7w1kh+EBdFI8iUEjZEdKBiK9UeeFPi3MnxnXZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342289; c=relaxed/simple;
	bh=3Z9tVvFNPyAAE1BEfI/X25TMFAvcbGnPg++lILWBKlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mZ44+lQI7nGHPqS3h9dDG6Uc0iQzg3OPPLjc2uW6msaVrHCZdiluCuaaghueeHQpwgXMe+x82NtsPVOpLrXki+0gD8b+FXH6ZVaG9qPMYf6P2xSwkho0IlHDS+F4jCk/2NQANlG1+h4E2LN4oSlh9MNGwDj2UDlkf7Vzb6QKEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1753342260-086e23295613750001-xx1T2L
Received: from ZXBJMBX02.zhaoxin.com (ZXBJMBX02.zhaoxin.com [10.29.252.6]) by mx1.zhaoxin.com with ESMTP id o2WpMInN1RTmCmqI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 24 Jul 2025 15:31:00 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 24 Jul
 2025 15:30:59 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Thu, 24 Jul 2025 15:30:59 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 24 Jul
 2025 15:24:34 +0800
Message-ID: <c52e3bc8-3618-cc99-a936-6576fef3215b@zhaoxin.com>
Date: Thu, 24 Jul 2025 23:24:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb:xhci:Fix slot_id resource race conflict
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] usb:xhci:Fix slot_id resource race conflict
To: Greg KH <gregkh@linuxfoundation.org>
CC: <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <WeitaoWang@zhaoxin.com>, <wwt8723@163.com>,
	<CobeChen@zhaoxin.com>
References: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>
 <2025072425-sixtyfold-curling-88ff@gregkh>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <2025072425-sixtyfold-curling-88ff@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/24/2025 3:30:58 PM
X-Barracuda-Connect: ZXBJMBX02.zhaoxin.com[10.29.252.6]
X-Barracuda-Start-Time: 1753342260
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1174
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.144741
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2025/7/24 14:36, Greg KH wrote:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On Thu, Jul 24, 2025 at 08:40:12PM +0800, Weitao Wang wrote:
>> @@ -4085,10 +4086,11 @@ static void xhci_free_dev(struct usb_hcd *hcd, s=
truct usb_device *udev)
>>        for (i =3D 0; i < 31; i++)
>>                virt_dev->eps[i].ep_state &=3D ~EP_STOP_CMD_PENDING;
>>        virt_dev->udev =3D NULL;
>> -     xhci_disable_slot(xhci, udev->slot_id);
>> +     ret =3D xhci_disable_slot(xhci, udev->slot_id);
>>
>>        spin_lock_irqsave(&xhci->lock, flags);
>> -     xhci_free_virt_device(xhci, udev->slot_id);
>> +     if (ret)
>> +             xhci_free_virt_device(xhci, udev->slot_id);
>>        spin_unlock_irqrestore(&xhci->lock, flags);
>=20
> Shouldn't you lock/unlock only if ret is set?

Yes,it's my mistake,here's code should like this:

ret =3D xhci_disable_slot(xhci, udev->slot_id);
if (ret) {
	spin_lock_irqsave(&xhci->lock, flags);
	xhci_free_virt_device(xhci, udev->slot_id);
	spin_unlock_irqrestore(&xhci->lock, flags);
}
Thanks for your suggestion. I'll revise it in the next patch version.

Best Regards,
weitao


> greg k-h
> .

