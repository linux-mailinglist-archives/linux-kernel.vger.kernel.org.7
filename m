Return-Path: <linux-kernel+bounces-877346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756C6C1DE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627D93B9553
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C211DF742;
	Thu, 30 Oct 2025 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHRYghhf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD331DD877
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783870; cv=none; b=SZ/TtaEanWTALhKWVE9PhqKsKlmW71+T6XPkBt6UjuF+h4DFXA+ooye5HPesgxQ5agGm5t5kEyrNy1IABsNdd5xJ3ErzdQeKvDlUdm/i5Oe4imT+UKyQSSyfLJVMhJIva/wd6LgjJJ0yUgJq4Irh5dzLX9aKUcS8SwPW+stVkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783870; c=relaxed/simple;
	bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5f721/veWDzy3RfpMAGGq5O/M7Hs28d6TxJ0C9e33EkcMEHjWRCpJWnrg4O2ug0qhm0s6+9jVRf317aw4LYjfDH8Qii2og+bxul+T91v90eudQ8CDAn5HnCRGAHBBI/HyK3HVD8Prt7XqBGsOPf7FqYsQ9glQqhsdWevV+FQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHRYghhf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so9455585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783867; x=1762388667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
        b=NHRYghhfkQvBTg9FloCLd24x86Tv3mKkfmd2h3rV79t2wicG73+mIYw5ObWgNM4XeW
         ZdNeR4CLV8pWF/KJC95TQAxBqsHuMMiMxauGAg72gnuaIskTioBPgnbsub9pJiKywVhV
         DLfdEOfYXKYK93aWKBBXAxoZMlviqYfrQBouoDv3k7WxV46v2G+6eBGCICAhKO86Nns5
         yXwroNAb6gIFfL/NtMtDcNEeAC1IfN05BT3JTIgh9jphYTWWO9LgzsXlKQOzRvzWgBg+
         huasfBwcHUWDmfhQ51dH3FCUe/pMnJ/5Jxeg0sOq5v9JG8zc1ZD0NDxGTDUSqrWRBNhO
         7I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783867; x=1762388667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
        b=E550tWP/1N1jVv7xmRNUZ/Zb8xzZiwlwJRrIR+cVydTXj1e+gPJ+ncbcpD91U+gvSK
         U81ac4YrJx8+ukcJYOhoxUDGfdG6Sylu1J6XU+xvS42dlRl+6XMKHcoRzoQY41lEd020
         RpHGFlL8Y00F9vaq+BOBjaEZGrN7lnvgiIy4nJaRYkxixPHSgFXsyZjhDfX3n/wijFFG
         8Uuk2dyrBf1l2OlnVBegz9og0fJyCbk2UU/ir1oCduWc0Aogg6PJrIXqCG4RIPAzzQsc
         HhRnlNymSNEOKUZuXpIMry9Bqw9jpSlr7TARO/pg/oFrDezc7m8sbB3QpbNWIaM5MJjU
         VIIg==
X-Forwarded-Encrypted: i=1; AJvYcCWj/TSrBDWqLwr9EnqUAco3dkH6QFqElbN9DMXFycwqWpDF2oSZ/gq6ZzpP/bZFAT3sVuLeRGIwzNyH1Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eMjJlnqDDIA24DTV9cCQIQUWgwYqlsGyC4P5JhMjX0e1++2O
	xetJ9DXUAaycm404kr9Iun33x6GxzUeV/n7fD6qO+etpMnpI8XLzDr52+KNtcmtksItUApHr2nu
	UqO+xtfK9btMmK/io5j82BWEf33EGARIZow==
X-Gm-Gg: ASbGncvOSf2pvcoTMwv3DFKocqi4vZV/r/GFaOdcjE6Pyem85XnUHU9MnvjZPonQ1Ze
	k3sAAdFZEn1ILdCH+IWBaARc3Vdzp7EbtXbJf4Z/Ff+03/UxpGYBKK9JWLIj14JjaLfxssG1wwu
	rCfb2o5hziYjRiOY3qpgmJLigo7a/aqWyebSd59wDJ+MgUjSsxy6fXBWc334Y7rZumuiyXNDX5+
	dvpkF/cKpdleQx2mbuxWEsm/i2NaUi4z/fSikfE7CFYZoJcYbHP/OF1DHo+kGbeA2FK5s0EMoQn
	WbQxz33gbLAClOflJQ==
X-Google-Smtp-Source: AGHT+IGrpyN5vXmTDxAJ2Hbps4KQtgd5KIZx2gAkx82y7AWs2BOA0ibbW+EbXbkybCTf6OBaGDisHC0/rb+R99V6Svo=
X-Received: by 2002:a05:6000:2584:b0:401:2cbf:ccad with SMTP id
 ffacd0b85a97d-429b4c56bbbmr1308255f8f.17.1761783866576; Wed, 29 Oct 2025
 17:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz> <CAADnVQ+nAA5OeCbjskbrtgYbPR4Mp-MtOfeXoQE5LUgcZOawEQ@mail.gmail.com>
 <a110ffdb-1e87-4a5a-b01b-2e7b0658ae33@suse.cz>
In-Reply-To: <a110ffdb-1e87-4a5a-b01b-2e7b0658ae33@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:24:15 -0700
X-Gm-Features: AWmQ_bm8V8LdP4A-G3QXinsd8ut065vtjAkDQw3A14j7is_ar0KxcjD8kryVmlU
Message-ID: <CAADnVQ+8x2b5qddRxU50xeq69XMY5RNi8ZfvTbERidKwTYrzqA@mail.gmail.com>
Subject: Re: [PATCH RFC 12/19] slab: remove the do_slab_free() fastpath
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:44=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>
> You mean the one that doesn't go the "if (unlikely(slab !=3D c->slab))" w=
ay?
> Well that unlikely() there might be quite misleading. It will be true whe=
n
> free follows shortly after alloc. If not, c->slab can be exhausted and
> replaced with a new one. Or the process is migrated to another cpu before
> freeing. The probability of slab =3D=3D c->slab staying true drops quickl=
y.
>
> So if your tests were doing frees shortly after alloc, you would be indee=
d
> hitting it reliably, but is it representative?
> However sheaves should work reliably as well too with such a pattern, so =
if
> some real code really does that significantly, it will not regress.

I see. The typical usage of bpf map on the tracing side is
to attach two bpf progs to begin/end of something (like function entry/exit=
),
then map_update() on entry that allocates an element, populate
with data, then consume this data in 2nd bpf prog on exit
that deletes the element.
So alloc/free happen in a quick succession on the same cpu.
This is, of course, just one of use cases, but it was the dominant
one during early days.

