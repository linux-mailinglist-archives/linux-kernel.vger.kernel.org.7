Return-Path: <linux-kernel+bounces-792998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FBB3CB57
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517B11899B66
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F24223337;
	Sat, 30 Aug 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAHJFzkG"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9017A309
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756562158; cv=none; b=iTjKZ0I4P2MgPtRjvJHNN0Jx0YSjxQg9Vp2phprwKSWITTWO81XZuo/kVyTN+eoh9sYkyd6v/B1MH3gs0Ck46TcIAirJ7hKf48W3ojfIHWKbwa7UyABYD9MjL1pR1C5Fl1NS93qECnSWCztuEhIZ5QdEC+gF1t9dwIRGRnzBQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756562158; c=relaxed/simple;
	bh=UljGajWu4DMZXPLgF2CeskJ2s+Qs+mbr0l08dbnI+qs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SpXpmdgNv0zCU6lrWo7VbIIX+xk2anNwBZUlEk/MhmafuzgV1lr0lHWsmR7Llj9h2w9u8MqT0ieEwEQy0ocHmVgGVAF5P7wJW/NjQos5ChQUxjR7UZhmF6BFGn4qQHGhAdeKRI8HTCxegTR34MNXNnhCWzAmi9WWdHC1WVXRNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAHJFzkG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704cdc76so304580085a.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756562156; x=1757166956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwFw00fP5hKsO5aLSWTxg80jBbSUw1HBbxbIBLPdq+w=;
        b=YAHJFzkGEqDRR/4lXIjMSDNBpu/ePgLC+vgDKYBZilH+8mTXEm8rSPXoGV+8Jn8iA7
         3A5IBvIMKOvVbBqED+IjDw3BhJMmq15l+p+tex2BXr98uTZjNFN8kpZMz2l7Q3iI8cVM
         ffw6ZHRMH84E+45zTg7/qL9jolkRiXDzfDgGOeWbONlJcJjNefB6eLWhfcSG1JjBmEDN
         Y/F4Xk1qwDBiS9jVi6UnGDu5QDIRyU19MWJ+eFDq1eVLnCZ7pxxHkkFZYJ0Q35WrOCzm
         IlY8iPHoyCNeq9H02Ltl2riwZn4Y6YE8MMzopR6kZ9gFG9+Kx6XP4zT52wNux5U/ce6Q
         89OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756562156; x=1757166956;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwFw00fP5hKsO5aLSWTxg80jBbSUw1HBbxbIBLPdq+w=;
        b=aD3SQGOTb78a7067TVWNlcv9u9Up5lDELQsBREjAc7DO5+I3ZoeEL12bu0MRrU910l
         0R5GyeQBUtJYLZJK7+KrtAucYG2XbdPZlX1QvvVm3+18b3qy3hBIWhAkNkmqQRl9Y/nI
         tHJCn9y0vYfyd3bTiey2/7AIqqlDuyHuuHIZo2ZRoi/Vc5MCURPLUfOUS643gQJqgBIA
         JW+/lb+e1MpF9kuwyevdSSr4dyFsp1upq46ub5N+ZHKEu2QipyBAwkHu4e0yqKSd0k6Q
         9dNTQD7lLf5IomSv7GLfYMgFH47wWWmnhqHNFkeooZmNxRPMM7G8ERel2lgKMSjKd9EE
         r6ig==
X-Forwarded-Encrypted: i=1; AJvYcCXY1FPGPoU3ROSdv4ZlxpzCpyWRAo8tNPoZ/kuSO4b6yFED3Hc/1P+HZNmfIYoE6ll07R2a74zQFWKSRKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdtVU5SJxM0XukKrk1wxvGytEPRjs2Im7Mdo/ION3pSDYQL3K
	cq0tJAHxbqKuEZYqTglGd56+dbs1bIvTBuycAZmLqnPvCA9cNY85oKeU
X-Gm-Gg: ASbGncvEMj/Rk+Wf3ZxsPaoU3BlKEQedKv+mrD/NoRGHvOCPj6n5dGNrEvNcny64k3T
	GyBiAq5SZPIGXbXr4MdwBqj4YAC+H0B8nLgiWlRE4zL7cHoG8Q9z50f6se/JLng9NCW4gwiXP+m
	oCWs/Bq73j1li35OGSGVp7WWjYuH/3EpnE5Rkv4FnBbSDJArLF11iKOnAOGx5MnJaJy0uNQcVho
	Ju+Ta/S6DjR6i8TPD6iFE/fIFq9aJkravt1lTcCM1w12tSqkz0dm4zJIkjVw4zm2Xv9VpbR0W4i
	bQIZeWKnGepNKMdgwKRqMQCbY12vcMgCgxDcX52Z0fyyNaHIG30GGe6CUZg5ab1eNIiK38sq9a7
	2R5//2tawqTkjr3qtCAdRXw2csTcc/awM8F7aGSDf++scp479Q2TJwrifh6/LIQ1vZgjMV9Nyms
	BxURTONBOjqpJiDLb8
X-Google-Smtp-Source: AGHT+IFHe3F8qBtgpqyIBOVJAb2wAE+VHgQKK55k+ksJZPNN3aisYWqD7QpfjxrEgl4iwh71mzA6dg==
X-Received: by 2002:a05:620a:468d:b0:7e8:507e:3b2d with SMTP id af79cd13be357-7ff2b0d9e3dmr187167885a.53.1756562155421;
        Sat, 30 Aug 2025 06:55:55 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6f5172sm32483681cf.51.2025.08.30.06.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 06:55:54 -0700 (PDT)
Date: Sat, 30 Aug 2025 09:55:54 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_auxdisplay=3A_line-display=3A_su?=
 =?US-ASCII?Q?pport_attribute_attachment_to_existing_device?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com>
References: <20250829010324.15595-1-jefflessard3@gmail.com> <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com>
Message-ID: <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 30 ao=C3=BBt 2025 05 h 15 min 23 s HAE, Andy Shevchenko <andy=2Eshevchen=
ko@gmail=2Ecom> a =C3=A9crit=C2=A0:
>On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
><jefflessard3@gmail=2Ecom> wrote:
>>
>> Modernize the line-display core library:
>> - Add the ability to attach line-display's sysfs attribute group direct=
ly
>>   to an existing parent device (not only via a child device) using
>>   device_add_groups(), allowing coherent integration with subsystems li=
ke
>>   the LED class=2E
>> - Implement a global linedisp_attachment mapping for unified and race-f=
ree
>>   attribute access, context lookup, and cleanup, shared between
>>   traditional register/unregister and new attach/detach paths=2E
>> - Modify sysfs attribute accessors to retrieve context using a consiste=
nt
>>   to_linedisp() mechanism=2E
>> - Add a new num_chars read-only attribute reporting the number of displ=
ay
>>   digits to allow static non-scrolling message from userspace=2E
>> - Ensures thread safety and proper list removal for all attachments
>>   operations=2E
>
>Thanks for working on this, can you split it into 5 patches?

My pleasure! Thanks for your feedback=2E

5 patches? I can't see how these changes could be split into 5 patches=2E
Maybe the commit message is too verbose and needs to be shortened=2E

If needed to be split into multiple patches, it could be:
1=2E Add attach/detach capability
2=2E Add num_chars sysfs attribute + ABI doc

I am also thinking to add a 3rd one to pad the message when length is smal=
ler
than num_chars=2E Current behavior is to wrap around which seems weird to =
me=2E
E=2Eg=2E for 4 chars:

Current behavior:
cat "123" > message
results in "1231" being displayed

Padded behavior:
cat "123" > message
would result in "123<blank>" being displayed

Any thoughts on that?

>More comments below=2E
>
>> Backwards compatibility with existing users is maintained, while enabli=
ng
>> uniform n-segment sysfs API and richer information for integrated drive=
rs=2E
>
>=2E=2E=2E
>
>> -#include <linux/container_of=2Eh>
>> +#include <linux/list=2Eh>
>
>Keep it ordered=2E
>

Acknowledged=2E My oversight=2E

>=2E=2E=2E
>
>> +static const struct device_type linedisp_type;
>
>Why? I don't see the use of this in the nearest below blocks of code=2E
>Can you move it closer to the first user so we can see the point?
>

This shouldn't have been submitted=2E This was part of a previous approach
I experimented with=2E Will remove=2E

>=2E=2E=2E
>
>> +       scoped_guard(spinlock, &linedisp_attachments_lock) {
>> +               list_add(&attachment->list, &linedisp_attachments);
>> +       }
>
>{} are not needed (same rule as with for-loop of if condition with one li=
ner)=2E
>
>> +       return 0;
>
>But in this case you can simply use guard()()=2E
>

Understood, I'll simply use guard()()=2E
=20
>=2E=2E=2E
>
>> +static struct linedisp *delete_attachment(struct device *dev, bool own=
s_device)
>> +{
>> +       struct linedisp_attachment *attachment, *tmp;
>> +       struct linedisp *linedisp =3D NULL;
>> +
>> +       scoped_guard(spinlock, &linedisp_attachments_lock) {
>
>Use guard()() and drop NULL assignment=2E
>

I'll use guard()()=2E

NULL assignment was to prevent invalid pointer in case the device is not f=
ound
in the list=2E But you are maybe suggesting to drop declaration of linedis=
p and
then directly return the linedisp within the loop and to return NULL after=
 the
loop?

>> +               list_for_each_entry_safe(attachment, tmp, &linedisp_att=
achments, list) {
>> +                       if (attachment->device =3D=3D dev &&
>> +                           attachment->owns_device =3D=3D owns_device)=
 {
>> +                               linedisp =3D attachment->linedisp;
>> +                               list_del(&attachment->list);
>> +                               kfree(attachment);
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +
>> +       return linedisp;
>> +}
>
>=2E=2E=2E
>
>> +static struct linedisp *to_linedisp(struct device *dev)
>
>As per above=2E
>

Same=2E

>=2E=2E=2E
>
>>  static struct attribute *linedisp_attrs[] =3D {
>>         &dev_attr_message=2Eattr,
>>         &dev_attr_scroll_step_ms=2Eattr,
>> +       &dev_attr_num_chars=2Eattr,
>
>This needs a Documentation update for a new ABI=2E
>

Agreed=2E I think it's also worth documenting the other ABIs along the way=
 since
they are not documented yet=2E Then, what Contact should be documented?
Is there an auxdisplay mailing list?

>>         &dev_attr_map_seg7=2Eattr,
>>         &dev_attr_map_seg14=2Eattr,
>>         NULL
>> };
>
>=2E=2E=2E
>
>> +int linedisp_attach(struct linedisp *linedisp, struct device *dev,
>> +                   unsigned int num_chars, const struct linedisp_ops *=
ops)
>> +{
>> +       int err;
>> +
>> +       memset(linedisp, 0, sizeof(*linedisp));
>> +       linedisp->ops =3D ops;
>> +       linedisp->num_chars =3D num_chars;
>> +       linedisp->scroll_rate =3D DEFAULT_SCROLL_RATE;
>
>> +       err =3D -ENOMEM;
>> +       linedisp->buf =3D kzalloc(linedisp->num_chars, GFP_KERNEL);
>> +       if (!linedisp->buf)
>> +               return err;
>
>You can simply return -ENOMEM without initial assignment=2E
>

Agreed, will return -ENOMEM=2E

>> +       /* initialise a character mapping, if required */
>> +       err =3D linedisp_init_map(linedisp);
>> +       if (err)
>> +               goto out_free_buf;
>
>The __free() can be used instead, but for uniform handling it's
>probably not needed here=2E
>

I think uniform handling is preferable here=2E Will keep as is=2E

>> +       /* initialise a timer for scrolling the message */
>> +       timer_setup(&linedisp->timer, linedisp_scroll, 0);
>> +
>> +       err =3D create_attachment(dev, linedisp, false);
>> +       if (err)
>> +               goto out_del_timer;
>> +
>> +       /* add attribute groups to target device */
>> +       err =3D device_add_groups(dev, linedisp_groups);
>> +       if (err)
>> +               goto out_del_attach;
>> +
>> +       /* display a default message */
>> +       err =3D linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
>> +       if (err)
>> +               goto out_rem_groups;
>> +
>> +       return 0;
>> +
>> +out_rem_groups:
>> +       device_remove_groups(dev, linedisp_groups);
>> +out_del_attach:
>> +       delete_attachment(dev, false);
>> +out_del_timer:
>> +       timer_delete_sync(&linedisp->timer);
>> +out_free_buf:
>> +       kfree(linedisp->buf);
>> +       return err;
>> +}
>


