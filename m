Return-Path: <linux-kernel+bounces-797131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB80CB40C33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719C2562E85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAB345722;
	Tue,  2 Sep 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJJsKDhn"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B634572B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834679; cv=none; b=PPSCoP2hVzjonmd04WoHjVZWvbIZq3AU/dpVF1ghIfZ9QQs2620g8EJwM+UZu6WQy/zpJcFJWWpYYL0P45vOnNbfpz1c7ESuu2t3rmh3Y8xBNZbcMyqicHj4cAikFQzxwvCZF4SzblCiSFOiVcPI4wbr7NA6OzmZjVPay09mxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834679; c=relaxed/simple;
	bh=VYGasW9FVPNTZ8VET90dXS7iMkynfbQXhIYVsHue9Hw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ST823+jTY0kC3wgz2QWH24Xl+zhnxtRWFPygjQjYbT251DbtP38ClAWX7b9T3FkKtmCKwTgh6b5gculx8HJ0LLnlVxT8xYDzEIy6G2qVnxLfoDedNvvdj2EE47G/d9PMGU2Th4x3vWVzo4wLqbcTDBfeyAJoEmIsffbZyr/bBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJJsKDhn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70de042246eso43815966d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756834677; x=1757439477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otrH9vPB0qBa0u4ndJlMzhUgcMoUjz9chpjKLQGboxY=;
        b=AJJsKDhnAmr3ZRaBJETVNLyJrFKSez16XW8doNREnUxxCrynYzXE3z9XVAOtUts8Lo
         QB97jZoYQ69vDjBTBDmSO9jdI9tgEG1fqnXbMBXwol60y9jxsgJIphTut1xlDLXs6FLd
         ULDoC2Kz8AgspZhau+CKbAe5kK3aixQkMWZV5XunbIKjDRPO/+s5MeYFHo9hX4HboTIW
         H3gI26sJYr26R7hE431nji+bJOaBSURth8dwRYjhS9cIsQcXRgXum0hdePAH11YV2Qy0
         pdBk69SzF6GuVYlsma3Kjllzji9UCitYGfgUzoPPP+LxOWN1cH+wrG7fDemovstLonlq
         /N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834677; x=1757439477;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otrH9vPB0qBa0u4ndJlMzhUgcMoUjz9chpjKLQGboxY=;
        b=YwLuG1yhhKeyy/zVmOQQapN/YqmAHX1OhmYdXKBt0atvpn9d2aHlLXJMLOJiAjFXrT
         aCvoaLzbUInXPKnF2cYYDPjzX4yqa+wIjgE782iZXxV1S8JNsiW/ERfRtPXTq5K+nYY+
         zfLBy7SasTDtgg4isjn0GLQDrUMzKo23/qcBCtDAr4MewHbv3lYnb6q7lzJ/mP77JcHI
         vyD0vbhwjpj1pPgq6nWhhjONFdEpxELEUMPuXux1E32RkXtTev9/lIWMLoVHs2P6oaFM
         xZyGbnMGnn6AoLPVPZlXqcJp4Cyuvw1fDLkO3ikNSGqxj9g2rBXXRiiOxamguNxFV3Lx
         MB4w==
X-Forwarded-Encrypted: i=1; AJvYcCWZYiw5SI8WMYeg9NKjgDRlNzGUW+1/0bXlkNm7ZjmKWwaB5uAwD60k/MyrcetHRza77AOMcgbOjaoUGV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbvIA6IKUosb/cfa58K+HrbHtB21ogDWSCOR63WUxDBCD6Dv+
	Urmcht7xLgMBaBh8smnJ1aIbc8Zm9MB1rFHDYwTvViWvWV3HfQeIFc6q
X-Gm-Gg: ASbGncuToOZ5Inr7AXpoi816PqcgB/0Z7lDR3Vpsw6BhlcvZf4rDH5o5XErp/9ic7dK
	KDOUuv8uGiywLjk8FjU3EXOvNeBUzj3sDWwArItA/7CEWtpBdR+4w6Uqb11nTCMMBVl2LpitunK
	AiK0AhzCcTnblBMYkNyK+jfy/Q8I4e8rRtoaSNqXUNCKebRRZNJMw+cM/XtKBSUAIdrbqB/T3BX
	vzT0YZFgkj6qTY9xojjkmbcgYapAFHZTMJTvfjruFan9BmBbeaGzUFXMmhbYVJHMdrqt7rl0mFV
	9d6CsprfiSenN9lAPQRaNb7W2egX3Epv8fgp7SDPaS9lscA8im3VIZN+sdC9IKL9iyovE0pFiW+
	rluNBdGB0C5FZweCTaxra3/MpnGlw8lD42/5vBckIAYlGaQg34j50s3RR9g59E3kjM9fbo3OMWg
	CXEkKuTzGR/HZISygb
X-Google-Smtp-Source: AGHT+IG/awK0cdVCA3tK+xvtx/vaBNKIY9HwI1AxLcqfUdWeVneKjrwj+PdCRYF9kxd5oB33rP1cMA==
X-Received: by 2002:a05:6214:62c:b0:722:47bd:8759 with SMTP id 6a1803df08f44-72247bd8d8bmr7749036d6.64.1756834676741;
        Tue, 02 Sep 2025 10:37:56 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ae045ef6sm14861906d6.31.2025.09.02.10.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:37:56 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:37:52 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/5=5D_auxdisplay=3A_linedisp=3A_suppor?=
 =?US-ASCII?Q?t_attribute_attachment_to_auxdisplay_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <aLbEcN44RT58ywzq@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <20250901020033.60196-5-jefflessard3@gmail.com> <aLbEcN44RT58ywzq@smile.fi.intel.com>
Message-ID: <9223FFA5-2B0F-4A74-AFE2-CB7C9703CFAB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 2 septembre 2025 06 h 18 min 24 s HAE, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> a =C3=A9crit=C2=A0:
>On Sun, Aug 31, 2025 at 10:00:28PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> Enable linedisp library integration into existing kernel devices (like =
LED
>> class) to provide a uniform 7-segment userspace API without creating
>> separate child devices, meeting the consistent interface while maintain=
ing
>> coherent device hierarchies=2E
>>=20
>> This allows uniform 7-segment API across all drivers while solving devi=
ce
>> proliferation and fragmented userspace interfaces=2E
>>=20
>> The provided attributes appear in two locations depending on usage:
>
>You wanted to say "=2E=2E=2Ein one of the two possible=2E=2E=2E"?
>Otherwise it looks like undesired side effect of the change=2E
>

Yes, your wording is much clearer=2E I will rephrase:

The provided attributes appear in one of the two locations depending on us=
age:

>>   1=2E On linedisp=2EN child devices (legacy linedisp_register())
>>   2=2E On the parent auxdisplay device (new linedisp_attach())
>> Functionality is identical in both modes=2E
>>=20
>> Existing consumers of linedisp_register() are unaffected=2E The new API
>> enables drivers like TM16XX to integrate 7-segment display functionalit=
y
>> seamlessly within their LED class device hierarchy=2E
>
>=2E=2E=2E
>
>> +struct linedisp_attachment {
>> +	struct list_head list;
>> +	struct device *device;
>> +	struct linedisp *linedisp;
>
>> +	bool owns_device;  /* true for child device mode, false for attached =
mode */
>
>I would rename this to=20
>
>	bool attached; // with inverted logic
>
>or
>	bool mode; // with "default" (false) mode to be actually legacy one
>
>(so in both cases I think we want false for the legacy mode)=2E
>

Understood=2E I will rename, invert logic and also document as kernel-doc =
instead
of inline comment=2E

>> +};
>
>=2E=2E=2E
>
>> +static DEFINE_SPINLOCK(linedisp_attachments_lock);
>
>Why spin lock and not mutex?
>

The attachment list operations are extremely lightweight (just adding/remo=
ving
list entries), making spinlock the optimal choice because:
- Very short critical sections: Only list traversal and pointer assignment=
s;
  avoids context switching overhead for brief operations
- No sleeping operations: No memory allocation or I/O within locked sectio=
ns
- Future-proof atomic context safety: Can be safely called from interrupt
  handlers if needed

>=2E=2E=2E
>
>> +/**
>> + * linedisp_attach - attach a character line display
>> + * @linedisp: pointer to character line display structure
>> + * @dev: pointer of the device to attach to
>> + * @num_chars: the number of characters that can be displayed
>> + * @ops: character line display operations
>> + *
>
>Can you add a description here, please? Important note that it should be =
freed
>by the respective API afterwards=2E
>

Yes, I will clarify that attach/register operations must be freed using
their corresponding detach/unregister operations=2E

>> + * Return: zero on success, else a negative error code=2E
>> + */
>
>=2E=2E=2E
>
>> +	/* add attribute groups to target device */
>> +	err =3D device_add_groups(dev, linedisp_groups);
>> +	if (err)
>> +		goto out_del_attach;
>> +
>> +	/* display a default message */
>> +	err =3D linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
>> +	if (err)
>> +		goto out_rem_groups;
>
>Can this be racy with user space? Once we publish attributes, the new
>message can be already issued and here it puts another message=2E
>OTOH this is done before device_add(), so the attributes are not visible
>until the device is added=2E
>

This concern is perfectly valid=2E linedisp_attach() can and will be calle=
d after
device_add() which can be racy=2E In fact, current linedisp_attach() repli=
cates
the linedisp_register() logic which is also racy since it displays initial
message after device_add()=2E It needs to be fixed in both attach/register=
 cases
by first initializing the display message before calling
device_add_groups()/device_add()=2E

>=2E=2E=2E
>
>> +void linedisp_detach(struct device *dev)
>> +{
>
>> +	struct linedisp *linedisp =3D delete_attachment(dev, false);
>> +
>> +	if (!linedisp)
>> +		return;
>
>Please, rewrite as
>
>	struct linedisp *linedisp;
>
>	linedisp =3D delete_attachment(dev, false);
>	if (!linedisp)
>		return;
>

Acknowledged=2E I will separate assignment from declaration=2E

>> +	timer_delete_sync(&linedisp->timer);
>> +
>> +	device_remove_groups(dev, linedisp_groups);
>> +
>> +	kfree(linedisp->map);
>> +	kfree(linedisp->message);
>> +	kfree(linedisp->buf);
>> +}
>


