Return-Path: <linux-kernel+bounces-793021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7DB3CBDC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE75E5BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130525785C;
	Sat, 30 Aug 2025 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrroAenF"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF91A7253
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756567304; cv=none; b=Pzckmy56K1esqPUbn+2XpvzX83+F7jhEX0WVjLd9qoyszd7u7wtys8lnxDEDnnhWOyw2e4NtQuQO9m9bQD/7/CqEjyhyi2anjfREkD1dca0AfQFmnH5/DT7YJ/pUQ/8ZBurp8ldGOTVvcaYelC5kQho/pUmOJbBsE3XMgKWEgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756567304; c=relaxed/simple;
	bh=+lh2VNnuSPziwOZtrtxQqok6CwsG45vDDwyEoPJ0X+k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ltSzUJJ/gYHmiu4jgP7+msG9+kyGLrhZF+AmMpzzIzBvISveUoCCKgeukHkj1omCUvfeqDtkSKSpKkRnjMk43MK/o4kFueeVAZ4L89y8SjucHgu/8uSg+KilrMS7K6AoAED9QfoPTDXPgienugZnQKszvaVPC5sA2qncLWG9i80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrroAenF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b308ace753so26374771cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756567301; x=1757172101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EvovdxMR1sWQKiXrJtJw2ESDFmmPWckzbgMTXrGulkM=;
        b=XrroAenFeibLRqQMttjDnkmaSRXQxxGGESJgIa+euS+KW7VEA9zunU4XQAQN1AmI2v
         3bnbhYdJqXPa7U1lhDTfkjngqIwVjROtl6xKfHWxKpFe5AHCbB42DytxDMpPRYI2Uhek
         79oWl2kWhjsr0AFkP5ytImnP1idFqc/5dnhnMsFEN4urAId9bpUSX0MrQcTXUtUg3bgt
         EajQdkRwN4XTbz4p0GqyY8y2kBrTLfZ3YmlJYQBJN8km49bPehE7IbcObAFGz4KGNcc6
         /PZF+Wg7RJSFP5zu+hqxXbSkuI2UlrtD0WfPCX2NaCBWvA47W+LbU+2SxUTyjjrEe6tW
         8foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756567301; x=1757172101;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvovdxMR1sWQKiXrJtJw2ESDFmmPWckzbgMTXrGulkM=;
        b=kH4IXYxSEzEnm8DgZ2L0G12ry36JQvH9wrXgdh/1Lu/iLCZFWQHdPkFOctG0Qv6klv
         uCkHh+z0m92KWlu8ATpcJxNSSsngzwfFtwFA1FE1UGB09Y+Y6sc16na8+R/vsRtF9dzM
         5pbrQYz51nWfgVMpTgkKsc6UC6wMMsN48FONARIWJTB20dFUwMICqRZOi3mUFMfZ6nqi
         67bT3dLOuTns21qLN4m5zSxY/OjX8AUttHPP/g6lO9YqbW+G/JS6VJfMI1rQvFejtM9q
         WcLFSLY/YowUxKlSIlgz3k6U0rm1rWkzxuYKcC08YwcKyzTcqbNAO6Nd/RGeE2IQPfbD
         Wbbw==
X-Forwarded-Encrypted: i=1; AJvYcCWJhWoVDX6f6R1wGPLinEzI12dHt+UPNB6Iy9DZwmEodHWV693kieFTqSxA5qIUv3nw9s4T+zPtwJOxymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdAOUeg6WHuxRPYuZE/9j03StJh2igvzL8a9+mQHUIAD3j1lC
	UJj4WQ6uw+tav7VAX4oZphDPKhYD3RIQHfhCe/4Zo2yt+9CUAHRfmSi/ji65NW0y
X-Gm-Gg: ASbGnctv7dwaFNpdCo9zi8tNQLJ0dO6WVeFtGbK6igda8xyckirFTyTKZYCg8eBZt5u
	Pe8SxoBq/Ds6jzTo5fwk4lh4hAQcglssDCskPnIEYgHSoPoqKlYG5knkXzT/MxlHwJxgp1BoMDG
	ulAHTmHZwLQ+eYcaBukZkJhcAlr3WUAG2NBbrb7pMuGzJhMITZjLN3xGtksH5ycRqV7pJkV7Ac5
	l44bPNleDh8O1/tCXXkAuRxuKA9JlQzZfKxeeCMoRXiojQfGn4PaKAWyP7jZMMItoRd6iJQq72f
	qZmzBTr2wkIpUsmMwv6AOAot+fY4Iu1HjRATz592jheKa9I1IK2Jk8VhXVBUb1RIxX3Byqgalhg
	/Knf/GOWH/aQEp8sN7xzMJHFuCOl6rp7vysd/EMW2X2R7Aafcam+m0ThFSblS0Y1SgUF4JipIf1
	8EIqq6jk+4e4dsD3Xm
X-Google-Smtp-Source: AGHT+IGMcgyvMMe7PPj8Zd+5B5Rw0H005X7uehPbL7iH6OM+kM7voAzAImQmnywktYb/t6Mja26jTA==
X-Received: by 2002:ac8:5f50:0:b0:4b3:1829:e67f with SMTP id d75a77b69052e-4b31d89d9famr24682801cf.2.1756567300914;
        Sat, 30 Aug 2025 08:21:40 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484956fsm375400185a.42.2025.08.30.08.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 08:21:40 -0700 (PDT)
Date: Sat, 30 Aug 2025 11:21:40 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_auxdisplay=3A_line-display=3A_su?=
 =?US-ASCII?Q?pport_attribute_attachment_to_existing_device?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAHp75Vc3DHUJwA+S4PGfoZxGtdqVq3GTF6_BEnJFo+=sFMmfDA@mail.gmail.com>
References: <20250829010324.15595-1-jefflessard3@gmail.com> <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com> <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com> <CAHp75Vc3DHUJwA+S4PGfoZxGtdqVq3GTF6_BEnJFo+=sFMmfDA@mail.gmail.com>
Message-ID: <587AE3BE-CD1F-4160-AA21-12B875E4EE81@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 30 ao=C3=BBt 2025 10 h 39 min 20 s HAE, Andy Shevchenko <andy=2Eshevchen=
ko@gmail=2Ecom> a =C3=A9crit=C2=A0:
>On Sat, Aug 30, 2025 at 4:55=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
><jefflessard3@gmail=2Ecom> wrote:
>> Le 30 ao=C3=BBt 2025 05 h 15 min 23 s HAE, Andy Shevchenko <andy=2Eshev=
chenko@gmail=2Ecom> a =C3=A9crit :
>> >On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
>> ><jefflessard3@gmail=2Ecom> wrote:
>> >>
>> >> Modernize the line-display core library:
>> >> - Add the ability to attach line-display's sysfs attribute group dir=
ectly
>> >>   to an existing parent device (not only via a child device) using
>> >>   device_add_groups(), allowing coherent integration with subsystems=
 like
>> >>   the LED class=2E
>> >> - Implement a global linedisp_attachment mapping for unified and rac=
e-free
>> >>   attribute access, context lookup, and cleanup, shared between
>> >>   traditional register/unregister and new attach/detach paths=2E
>> >> - Modify sysfs attribute accessors to retrieve context using a consi=
stent
>> >>   to_linedisp() mechanism=2E
>> >> - Add a new num_chars read-only attribute reporting the number of di=
splay
>> >>   digits to allow static non-scrolling message from userspace=2E
>> >> - Ensures thread safety and proper list removal for all attachments
>> >>   operations=2E
>> >
>> >Thanks for working on this, can you split it into 5 patches?
>>
>> My pleasure! Thanks for your feedback=2E
>>
>> 5 patches? I can't see how these changes could be split into 5 patches=
=2E
>> Maybe the commit message is too verbose and needs to be shortened=2E
>>
>> If needed to be split into multiple patches, it could be:
>> 1=2E Add attach/detach capability
>> 2=2E Add num_chars sysfs attribute + ABI doc
>
>Yeah, the commit message was a list of 5 things, hence 5 patches=2E I
>haven't read closely to map each listed feature to the possible
>change=2E  The description of to_linedisp() sounds like it can be split
>to a separate patch=2E I really want to see the attachment/detachment
>patch separate with the explanation "why?"=2E I am not sure I see the
>point=2E
>

I will shorten commit message and clarify the "why":

Enable linedisp library integration into existing kernel devices
(like LED class) to provide uniform 7-segment userspace API without creati=
ng
separate child devices, meeting consistent interface while maintaining
coherent device hierarchies=2E

This allows uniform 7-segment API across all drivers while solving device
proliferation and fragmented userspace interfaces=2E

Note that there is no point in introducing to_linedisp() based on attachme=
nts
without attach/detach capability=2E Current implementation is actually cor=
rect
if only supporting registration of child devices=2E

>> I am also thinking to add a 3rd one to pad the message when length is s=
maller
>> than num_chars=2E Current behavior is to wrap around which seems weird =
to me=2E
>> E=2Eg=2E for 4 chars:
>>
>> Current behavior:
>> cat "123" > message
>> results in "1231" being displayed
>>
>> Padded behavior:
>> cat "123" > message
>> would result in "123<blank>" being displayed
>>
>> Any thoughts on that?
>
>It's basically the question of circular vs=2E one time message exposure=
=2E
>When it's one time, the padding makes sense, otherwise the current
>(circular) behaviour seems normal to me=2E
>

I get your point but I should have noted that current behavior is to wrap =
but
does NOT scroll=2E That's why it seems wrong to me=2E It should either wra=
p AND
scroll, or otherwise simply pad=2E

>> >More comments below=2E
>> >
>> >> Backwards compatibility with existing users is maintained, while ena=
bling
>> >> uniform n-segment sysfs API and richer information for integrated dr=
ivers=2E
>
>=2E=2E=2E
>
>> >> +static struct linedisp *delete_attachment(struct device *dev, bool =
owns_device)
>> >> +{
>> >> +       struct linedisp_attachment *attachment, *tmp;
>> >> +       struct linedisp *linedisp =3D NULL;
>> >> +
>> >> +       scoped_guard(spinlock, &linedisp_attachments_lock) {
>> >
>> >Use guard()() and drop NULL assignment=2E
>>
>> I'll use guard()()=2E
>>
>> NULL assignment was to prevent invalid pointer in case the device is no=
t found
>> in the list=2E But you are maybe suggesting to drop declaration of line=
disp and
>> then directly return the linedisp within the loop and to return NULL af=
ter the
>> loop?
>
>This won't work as you want to clean up the things=2E
>
>> >> +               list_for_each_entry_safe(attachment, tmp, &linedisp_=
attachments, list) {
>> >> +                       if (attachment->device =3D=3D dev &&
>> >> +                           attachment->owns_device =3D=3D owns_devi=
ce) {
>> >> +                               linedisp =3D attachment->linedisp;
>> >> +                               list_del(&attachment->list);
>> >> +                               kfree(attachment);
>> >> +                               break;
>> >> +                       }
>> >> +               }
>> >> +       }
>> >> +
>> >> +       return linedisp;
>> >> +}
>
>The usual approach here is to use list_entry_is_head() after the loop=2E
>
>  list_for_each_entry() {
>    if (=2E=2E=2E)
>      break;
>  }
>
>  if (list_entry_is_head(=2E=2E=2E))
>    return NULL;
>
>  linedisp =3D =2E=2E=2E
>  =2E=2E=2E
>  return linedisp;
>

Thanks for this pattern=2E I'll implement it=2E

>=2E=2E=2E
>
>> >> +static struct linedisp *to_linedisp(struct device *dev)
>> >
>> >As per above=2E
>>
>> Same=2E
>
>Same=2E
>
>=2E=2E=2E
>
>> >> +       &dev_attr_num_chars=2Eattr,
>> >
>> >This needs a Documentation update for a new ABI=2E
>>
>> Agreed=2E I think it's also worth documenting the other ABIs along the =
way since
>> they are not documented yet=2E Then, what Contact should be documented?
>> Is there an auxdisplay mailing list?
>
>Your or no-one's? Is it a mandatory field? In any case the ABI must be
>documented, w=2Eo=2E doing that any good patch is simply NAK
>automatically=2E
>

I thought contact was mandatory but after looking closer, there are multip=
le
existing precedents where there is no documented contact=2E I think it wou=
ld be
appropriate to add my contact to the added num_chars property documentatio=
n,
but to add documentation of the other existing properties with no contact=
=2E



