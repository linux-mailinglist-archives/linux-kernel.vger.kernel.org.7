Return-Path: <linux-kernel+bounces-882663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB5C2B15E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93B624F36A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C202FE570;
	Mon,  3 Nov 2025 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1YTbn6Dz"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3712FE04A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165907; cv=none; b=JTH0uozLRu+hzOA0adEyupfgXOy9KlsLk7dPA6OIiB7QShV7PJ4+BBDzjMSBH7AQDyExwrh2DTsPkrh+mDqYZn+ijnoRYF1kRffGhTrYtELHGo+UaK/hPhK7yjY1B2FH+az+LN6yTTSZ9pX1podgvhuTFT3l0NisWh0GKsyGTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165907; c=relaxed/simple;
	bh=m5ybLjWP+Dpu8vcYkjzGVenOwZvocctdHG+nNdQ/i6s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EJ/oQlieihWJvVOb2ioMdUZQgURCwiLBmxcFl3mqXDfzZAJNVEeG7CPwsrZ1sf2g0jateGJGnF0iNNd4j3Zcquyrj9Ge4fBEW7rC1LZEGzPZF2cyu9cGYSgreSEXSnLUdy+JF05yM4GKrJxmqexsAGmnEoEL8xgpAlqZDzeIX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1YTbn6Dz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c2db014easo886275866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762165902; x=1762770702; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev+FutBx57/FNBFPUNtXOR1Qu8cLklW5P/s1yrMZQhc=;
        b=1YTbn6DzPdy2PVNHfkf8q3xXKYATURHcoeESD6EFgwBcSlpJJYf7qX+SNimY1YBFkA
         CEAUhcDB6sJN+SPe3D0Yq4lg4forc/+WUWJj/+Qd2fH/XjbQiS/wJpuQIEi1S3vU1QAf
         9hei2MYyCPGWsTxpapc9KfzTydzc/S0Xon7i6/Yxk0uI9sBr02ydpQPo3CEI3pEJYTVx
         Op4KxTFR6mybfJyRpl8lXVH1E4txKu5GZyDg/G+dn+Fspf/ECpnn2t8ygq8p0bBQi4Mw
         y5KCzoNEpuWRrfnZx9vnVdmy1nmWDq3668FR3p8jnYRbk0wKFrgLbUnHOj2hVWLc+Ch1
         Giag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165902; x=1762770702;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev+FutBx57/FNBFPUNtXOR1Qu8cLklW5P/s1yrMZQhc=;
        b=BkpTQs6NEdL7B18mT48t/EEPVMKAkfqKDAgWQu+9PPQ+1nRkHJ4OHBqrPTr+1rSSak
         ZG5TkqWQjBvSRwHaM7D9dCaxcV+Ti38MP2etNq8jWaVKriqDYEdxhWYI8N8fyfB9sNNX
         mFK0I/tL/RvpuY5hPvMT204jkkyRGOjamh5+6SdrRJa+AsdvWQqDNAgweleWr2JtE9OU
         BmemiEnoaL+AZHrxiMsZt/rapijihKTWnarLSyNO7lOgD/Xy+cxrhp4UfPPmjreU9i49
         adrKV8+vlP5dJXHoS9YrFqDNnrMva46eqHoBt8NhbvSaLxdLb0IHZLCwiByg/VAHIpxr
         Wi0g==
X-Forwarded-Encrypted: i=1; AJvYcCVMKyGfWClr5bbnbtklAorkJtEezVJlQeitCs1GUQ/dmxrB/0UG12k7SzOzluCojbvhaa567dRdfpMkJ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBhyKg3oHUF3SKRFFsB/wXGc+JW4pzvqdzwWl3gIRGKk3JpM0
	s2SJhpwO7faytf3KbLEQbfacsjlvkm+/U3HkK0DBSFYZ7BBJM9dUc3nJwSfPmNWTUis=
X-Gm-Gg: ASbGncsiBtl2wFVKNvfaJXjRR1Z/OBQoBMmaNwb3ljwVTM9vv0soVuhoz1i6R5Ghr4z
	ngfSgnwG2O1q1uK5id4LpoXHkAB0Gv2pYGqfwf71MkszZC7sRco7ZmHtSQfkZmt5SADDjyf5mZm
	0aA6OLU4v48goerecRvSA8eC/yDCTGo84KAV/mzo3CgPW32xYjKTKsicCDUBoBqE5rRnxX2hEt0
	r7/jxFfLhWxSw8Jo4SkB1d+o1WTc6KZcRvx/FltMB+p/wioOMUDiJVgqhLytslp3wH9Qm/yVX5S
	Y/zFw3vm4W4L26VrPobf27CJmb/pkioFCXUszVrFt9WvUvqnti0v+adWv/xKxCeXqVo+6nj0HXg
	VJCowQv0jtH2jVdtAChcACOIexr2z9QMJt7Z578D/5uAP6ISXW5eA5QuSl4D8pcfpJi6d
X-Google-Smtp-Source: AGHT+IE11zTQ7CCDiBUde1gGw8+g3Hsu0UVIKx9O4gSlkL+kMqtUKG4Migng/Rjq4y9baGdVTMcXrg==
X-Received: by 2002:a17:907:3c8d:b0:b30:ead5:56d0 with SMTP id a640c23a62f3a-b707087a3f3mr1190934066b.61.1762165902387;
        Mon, 03 Nov 2025 02:31:42 -0800 (PST)
Received: from localhost ([62.246.251.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438afasm9367567a12.30.2025.11.03.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d3b267eaf3d3b01695c425cab7bcb0fa2d52bdf1620d5ecf21626e95c9b6;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 03 Nov 2025 11:31:35 +0100
Message-Id: <DDYZOCXFX1J2.30UFCSI059R9V@baylibre.com>
Subject: Re: [PATCH v9 3/3] firmware: ti_sci: Partial-IO support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Andrew Davis" <afd@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, "Nishanth Menon" <nm@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Santosh Shilimkar" <ssantosh@kernel.org>
Cc: "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com> <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com> <d3209c85-dc30-4f9a-8ea5-3c3e19330afd@ti.com>
In-Reply-To: <d3209c85-dc30-4f9a-8ea5-3c3e19330afd@ti.com>

--d3b267eaf3d3b01695c425cab7bcb0fa2d52bdf1620d5ecf21626e95c9b6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 30, 2025 at 3:24 PM CET, Andrew Davis wrote:
> On 10/30/25 4:26 AM, Markus Schneider-Pargmann (TI.com) wrote:
>> Add support for Partial-IO poweroff. In Partial-IO pins of a few
>> hardware units can generate system wakeups while DDR memory is not
>> powered resulting in a fresh boot of the system. These hardware units in
>> the SoC are always powered so that some logic can detect pin activity.
>>=20
>> If the system supports Partial-IO as described in the fw capabilities, a
>> sys_off handler is added. This sys_off handler decides if the poweroff
>> is executed by entering normal poweroff or Partial-IO instead. The
>> decision is made by checking if wakeup is enabled on all devices that
>> may wake up the SoC from Partial-IO.
>>=20
>> The possible wakeup devices are found by checking which devices
>> reference a "Partial-IO" system state in the list of wakeup-source
>> system states. Only devices that are actually enabled by the user will
>> be considered as an active wakeup source. If none of the wakeup sources
>> is enabled the system will do a normal poweroff. If at least one wakeup
>> source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
>> message from the sys_off handler. Sending this message will result in an
>> immediate shutdown of the system. No execution is expected after this
>> point. The code will wait for 5s and do an emergency_restart afterwards
>> if Partial-IO wasn't entered at that point.
>>=20
>> A short documentation about Partial-IO can be found in section 6.2.4.5
>> of the TRM at
>>    https://www.ti.com/lit/pdf/spruiv7
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   drivers/firmware/ti_sci.c | 132 ++++++++++++++++++++++++++++++++++++++=
+++++++-
>>   drivers/firmware/ti_sci.h |   5 ++
>>   2 files changed, 136 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 4db84a92a517b0aa7bb8d47e809d9848a16e2cc4..f2922fccfbe748a436cb9aa0=
a8c8e5f48db02ef9 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -6,6 +6,7 @@
>>    *	Nishanth Menon
>>    */
>>  =20
>> +#include "linux/dev_printk.h"
>>   #define pr_fmt(fmt) "%s: " fmt, __func__
>>  =20
>>   #include <linux/bitmap.h>
>> @@ -3663,6 +3664,116 @@ devm_ti_sci_get_resource(const struct ti_sci_han=
dle *handle, struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
>>  =20
>> +/*
>> + * Enter Partial-IO, which disables everything including DDR with only =
a small
>> + * logic being active for wakeup.
>> + */
>> +static int ti_sci_enter_partial_io(struct ti_sci_info *info)
>> +{
>> +	struct ti_sci_msg_req_prepare_sleep *req;
>> +	struct ti_sci_xfer *xfer;
>> +	struct device *dev =3D info->dev;
>> +	int ret =3D 0;
>> +
>> +	xfer =3D ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
>> +				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
>> +				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
>> +	if (IS_ERR(xfer)) {
>> +		ret =3D PTR_ERR(xfer);
>> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	req =3D (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
>> +	req->mode =3D TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
>
> This whole function is almost identical to ti_sci_cmd_prepare_sleep() oth=
er
> than you use a different mode here, which this different mode can be pass=
ed
> into ti_sci_cmd_prepare_sleep() just the same. Only other difference woul=
d
> be the NORESPONSE flag which you could just check "mode" passed in and
> use the right flag for the mode.

I thought this to be nicer as it avoided ifs, but as Kendall and you
both requested this, I changed it for the next version.

>
>> +	req->ctx_lo =3D 0;
>> +	req->ctx_hi =3D 0;
>> +	req->debug_flags =3D 0;
>> +
>> +	ret =3D ti_sci_do_xfer(info, xfer);
>> +	if (ret) {
>> +		dev_err(dev, "Mbox send fail %d\n", ret);
>> +		goto fail;
>> +	}
>> +
>> +fail:
>> +	ti_sci_put_one_xfer(&info->minfo, xfer);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Iterate all device nodes that have a wakeup-source property and chec=
k if one
>> + * of the possible phandles points to a Partial-IO system state. If it
>> + * does resolve the device node to an actual device and check if wakeup=
 is
>> + * enabled.
>> + */
>> +static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
>> +{
>> +	struct device_node *wakeup_node =3D NULL;
>> +
>> +	for_each_node_with_property(wakeup_node, "wakeup-source") {
>> +		struct of_phandle_iterator it;
>> +		int err;
>> +
>> +		of_for_each_phandle(&it, err, wakeup_node, "wakeup-source", NULL, 0) =
{
>> +			struct platform_device *pdev;
>> +			bool may_wakeup;
>> +
>> +			/*
>> +			 * Continue if idle-state-name is not off-wake. Return
>> +			 * value is the index of the string which should be 0 if
>> +			 * off-wake is present.
>> +			 */
>> +			if (of_property_match_string(it.node, "idle-state-name", "off-wake")=
)
>> +				continue;
>> +
>> +			pdev =3D of_find_device_by_node(wakeup_node);
>> +			if (!pdev)
>> +				continue;
>> +
>> +			may_wakeup =3D device_may_wakeup(&pdev->dev);
>> +			put_device(&pdev->dev);
>> +
>> +			if (may_wakeup) {
>> +				dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO=
\n",
>> +					wakeup_node);
>> +				of_node_put(it.node);
>> +				of_node_put(wakeup_node);
>> +				return true;
>> +			}
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int ti_sci_sys_off_handler(struct sys_off_data *data)
>> +{
>> +	struct ti_sci_info *info =3D data->cb_data;
>> +	bool enter_partial_io =3D ti_sci_partial_io_wakeup_enabled(info);
>> +	int ret;
>> +
>> +	if (!enter_partial_io)
>> +		return NOTIFY_DONE;
>> +
>> +	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enab=
led device was found.\n");
>> +
>> +	ret =3D ti_sci_enter_partial_io(info);
>> +
>
> No need for newline here.
>
>> +	if (ret) {
>> +		dev_err(info->dev,
>> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n=
",
>> +			ERR_PTR(ret));
>
> Why cast this int to a pointer before printing it out?

I am casting this to an error pointer to get the resolution of the error
value to a symbolic name with %pe. This will print 'EBUSY' etc.

Thanks!

Best
Markus

--d3b267eaf3d3b01695c425cab7bcb0fa2d52bdf1620d5ecf21626e95c9b6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaQiEhxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNB
ewEAzqNa+34X6+y+Ev+PL2U/s/P4kMziVU1jKpfSLWY12XQBANXHThqEN3gUgXRw
ba7ULqDxdztsMTeTll24hghNKqIA
=zC3u
-----END PGP SIGNATURE-----

--d3b267eaf3d3b01695c425cab7bcb0fa2d52bdf1620d5ecf21626e95c9b6--

