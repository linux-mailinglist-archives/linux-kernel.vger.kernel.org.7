Return-Path: <linux-kernel+bounces-793063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958FB3CD93
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6017C186D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B402765DC;
	Sat, 30 Aug 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM1UdgWt"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC41E502
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573037; cv=none; b=kBdbZJUc0U+E09avBqJKZbO0StG/YGWX8CJBsvH80nBKHA8zqazBc4vc4pJXJQiylDRXgJYSaJe8KLUIESUsDp+ESoJ3adED7hUiQs5m6H6sC5maNG8RCE8faw245oWijK8MuliByrClXNXouU4Lh0IrtBWrSvBNCHBAqFHgZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573037; c=relaxed/simple;
	bh=0dLM/JlLR2IdlsCY/KWOKEsK5y0Ub/11OcgXLUyACHo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fTiZqFC/Nb4Nwulz6saSqTypaZ0h6AbRYyRuGKXrA0Zhm38Wb1Jm6ccxigrGASlHQtrunK3aH2fcR/D9ak8jkTqhtTsAjHmDLrwh92OoKh4fYRN2kh/4YkMrkfWIZin3A6pP5C6WiB21Xn4IcYATcnI/c/DFdKk6ccDwzD+QQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM1UdgWt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70ba7aa136fso22291816d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756573034; x=1757177834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naz4Rk0c238Hbx+wWFZilV7Za10Nupkf9ifLWqaGS2A=;
        b=KM1UdgWtiNmz0hyHHfmuK/6zbWYoNjyVD0TMWNZlaZogVbGT/3h033br1YCWN6hQ3F
         lfoCBIclLgMHenF9w0ZOxnhpQoCKeLFlOncWf5sy0ORMGNVII7m368E4mVbipXBGv9Qs
         OutmiPAmBNnLrJhEBKW8H7Xg1qvvsRQ05VA/e6o/9bLRWpOtPn/4v6ppDSKF70uUg0b4
         DdfEJCB6HWB6jNKv+fDNr9WTfhqMxpL/VCYGd/44UyifZy2xwRwT9f3/SzZymeU5WtM0
         bwlYx98ZQppF7I6SFSo6uwF2EHiTb7mD+3uLQhaY2Is3ZlL/YGI3iXBh7/48Mit4AfAf
         64Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756573034; x=1757177834;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naz4Rk0c238Hbx+wWFZilV7Za10Nupkf9ifLWqaGS2A=;
        b=qvUh4JGZ50FujW8yAeVQvB1/XuUlpiJu4vkgUW99ov7e3gHy0YPWCad31ksuCGz9xY
         1znFvPd9lYEwhgSh8EGSywR+BJf6fsu8lgg5JhYTrQrtc4DtgBk5ebikp6V/PdSmOyos
         vtSTNqwXt3NSL9YyfljFZFQLwflSAbk2YAwZPBguS4yLEVEoJdSlwWA1SRgLeBoi+SLb
         jCOFQ/qLIokxckCe3zLMf7MJTdQo1g9R5K5O+72wT/zic5WbAs0095XWjZCra8gwqseA
         a38glgyy//GK1sVnB/283nIaKZw/b4EtWW8mU/V5SERyUwSrZurJDNQnywD+LKiwEzLT
         Latg==
X-Forwarded-Encrypted: i=1; AJvYcCVBPqjQoTBbNWR/bTyQQiHXSA8X+wlERFjbn+RbQ6Lmwpq3crOs/g/JzK8pyacnuEgUH0uZaM1MLR+e/Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XusZM6aokWKUJSAcV+wtmtGXsBdtZ0oiLhPUzYVRqDD0wNzD
	m6MQPQJi/jdB8r0e/y4SpPoZ69QzuBN0azDXvKyBhsAZq7MyEkQOGvPK7wug+/nt
X-Gm-Gg: ASbGnctsEXRJLIn4NXw9b5fWUnZ5WZJPR5kgHije6Q2pbZ+JRclQah8B5LrM/odU1Vz
	qZkjTfNdQ8xGZla6KVqsxhjQLw0ymujc6xvKvrSvPj5eVgJ78/jB7SGD3C4q7gAxLCzegSqajcN
	lx7ZV0mpQG1eK2MyMc+Aik49ER9S2wGRGGmEoyKzBSNREjVfWEbycqJu3imc5ea5Hdnk/uWKYDj
	wRRl1GKwfuHREbfF7JuKgrYVR4DdpCuZKog1PCcjDVMuWp2O+97wg4XSkwTgrKPU20EcQv3tXye
	cL8WLnrd8aVq4oseJd7UDqBbTAao5kPeIGLN6fcBBfgIhMQwVygGRcFEtqQTmuNE+jo7KGTcZHO
	XrJob5zs7GzD2j6/VNVmiLiHzWmPGe6ExpBx3Sp1HIsvcJCEBrgrMrmmjoWiRwBIaYHs304WXHq
	1ZcO7PxF9lSNzkuppY
X-Google-Smtp-Source: AGHT+IExgARQILpJFYYOxkDlXx4k/PTP9UsHoFaUCcXNPbN/ALY6lDWNh0HHGCXvZBJ8cftc2lhZUQ==
X-Received: by 2002:a05:6214:4107:b0:70d:9a7c:d677 with SMTP id 6a1803df08f44-70fac8d352amr29414456d6.53.1756573033503;
        Sat, 30 Aug 2025 09:57:13 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb263e092sm8528096d6.32.2025.08.30.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 09:57:13 -0700 (PDT)
Date: Sat, 30 Aug 2025 12:57:13 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_auxdisplay=3A_line-display=3A_su?=
 =?US-ASCII?Q?pport_attribute_attachment_to_existing_device?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAHp75VeetsQ0NgVEnhic3wdUs-w0q7nQoGX4rO3aNdq8feypRg@mail.gmail.com>
References: <20250829010324.15595-1-jefflessard3@gmail.com> <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com> <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com> <CAHp75Vc3DHUJwA+S4PGfoZxGtdqVq3GTF6_BEnJFo+=sFMmfDA@mail.gmail.com> <587AE3BE-CD1F-4160-AA21-12B875E4EE81@gmail.com> <CAHp75VeetsQ0NgVEnhic3wdUs-w0q7nQoGX4rO3aNdq8feypRg@mail.gmail.com>
Message-ID: <E12E0A91-8B9A-4326-96DD-10078BEA81F1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 30 ao=C3=BBt 2025 12 h 18 min 27 s HAE, Andy Shevchenko <andy=2Eshevchen=
ko@gmail=2Ecom> a =C3=A9crit=C2=A0:
>On Sat, Aug 30, 2025 at 6:21=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
><jefflessard3@gmail=2Ecom> wrote:
>> Le 30 ao=C3=BBt 2025 10 h 39 min 20 s HAE, Andy Shevchenko <andy=2Eshev=
chenko@gmail=2Ecom> a =C3=A9crit :
>> >On Sat, Aug 30, 2025 at 4:55=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
>> ><jefflessard3@gmail=2Ecom> wrote:
>> >> Le 30 ao=C3=BBt 2025 05 h 15 min 23 s HAE, Andy Shevchenko <andy=2Es=
hevchenko@gmail=2Ecom> a =C3=A9crit :
>> >> >On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
>> >> ><jefflessard3@gmail=2Ecom> wrote:
>
>=2E=2E=2E
>
>> >> If needed to be split into multiple patches, it could be:
>> >> 1=2E Add attach/detach capability
>> >> 2=2E Add num_chars sysfs attribute + ABI doc
>> >
>> >Yeah, the commit message was a list of 5 things, hence 5 patches=2E I
>> >haven't read closely to map each listed feature to the possible
>> >change=2E  The description of to_linedisp() sounds like it can be spli=
t
>> >to a separate patch=2E I really want to see the attachment/detachment
>> >patch separate with the explanation "why?"=2E I am not sure I see the
>> >point=2E
>>
>> I will shorten commit message and clarify the "why":
>>
>> Enable linedisp library integration into existing kernel devices
>> (like LED class) to provide uniform 7-segment userspace API without cre=
ating
>
>a uniform
>

Acknowledged=2E

>> separate child devices, meeting consistent interface while maintaining
>
>the consistent
>

Acknowledged=2E

>> coherent device hierarchies=2E
>>
>> This allows uniform 7-segment API across all drivers while solving devi=
ce
>> proliferation and fragmented userspace interfaces=2E
>
>Yes, this is a good start=2E
>

Great=2E I will submit the attach capability in a separate patch clarifyin=
g this=2E

>> Note that there is no point in introducing to_linedisp() based on attac=
hments
>> without attach/detach capability=2E Current implementation is actually =
correct
>> if only supporting registration of child devices=2E
>
>This can be made in a series, so the order will suggest the
>dependencies immediately=2E
>

Agreed=2E Series would then be:
1=2E attachment list + to_linedisp()
2=2E attach to existing device capability
3=2E num_digits attribute + ABI docs

I guess this should be an independent patch series than the tm16xx patch s=
eries=2E
Isn't it an issue to submit code without a real user? I mean, tm16xx would=
 be
the first attach/detach consumer=2E

>=2E=2E=2E
>
>> >> I am also thinking to add a 3rd one to pad the message when length i=
s smaller
>> >> than num_chars=2E Current behavior is to wrap around which seems wei=
rd to me=2E
>> >> E=2Eg=2E for 4 chars:
>> >>
>> >> Current behavior:
>> >> cat "123" > message
>> >> results in "1231" being displayed
>> >>
>> >> Padded behavior:
>> >> cat "123" > message
>> >> would result in "123<blank>" being displayed
>> >>
>> >> Any thoughts on that?
>> >
>> >It's basically the question of circular vs=2E one time message exposur=
e=2E
>> >When it's one time, the padding makes sense, otherwise the current
>> >(circular) behaviour seems normal to me=2E
>>
>> I get your point but I should have noted that current behavior is to wr=
ap but
>> does NOT scroll=2E That's why it seems wrong to me=2E It should either =
wrap AND
>> scroll, or otherwise simply pad=2E
>
>Ah, that's an interesting observation=2E I think we need to ask Geert
>and others about their opinions on this=2E To me it seems like you have
>a point=2E
>

Let's see Geert and others feedback on this=2E If no feedback, I will subm=
it a 4th
patch to the series that would display static (non-scrolling) padded messa=
ge
when length <=3D num_chars=2E

>=2E=2E=2E
>
>> >> >> +       &dev_attr_num_chars=2Eattr,
>> >> >
>> >> >This needs a Documentation update for a new ABI=2E
>> >>
>> >> Agreed=2E I think it's also worth documenting the other ABIs along t=
he way since
>> >> they are not documented yet=2E Then, what Contact should be document=
ed?
>> >> Is there an auxdisplay mailing list?
>> >
>> >Your or no-one's? Is it a mandatory field? In any case the ABI must be
>> >documented, w=2Eo=2E doing that any good patch is simply NAK
>> >automatically=2E
>>
>> I thought contact was mandatory but after looking closer, there are mul=
tiple
>> existing precedents where there is no documented contact=2E I think it =
would be
>> appropriate to add my contact to the added num_chars property documenta=
tion,
>> but to add documentation of the other existing properties with no conta=
ct=2E
>
>Good for me=2E
>

Will do so=2E


