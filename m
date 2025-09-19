Return-Path: <linux-kernel+bounces-824076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E5B8811E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E75C1C2764B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6AA2BDC28;
	Fri, 19 Sep 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snKAg8St"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D125A33A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265142; cv=none; b=Iv4VNsr656Oc1CwLsRzn726zRYt4SeU0wFbfHONL6piPTvf/unycW3I44nh/LDegnuyuz/1TpMRV+XMLzsE5Wyf7cllPfaYJXvkClHuP8b8dcpVO5ObR4eawoABbXAKhQf39i2912tZLATgNkwd916/5Pkpkk0/xHr3zt5reBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265142; c=relaxed/simple;
	bh=fVN5tDlHAI/9OvCcgBugJ8NEpgN9vTgXdv+CmXJfQeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJcF2NR1zpQS1e7RomvpLjpLXurhg3J3CNSK/+11p+2Mk5w3XVKJc1FuF0xJGL6qcEwKgC7H+wTVCVyQO8p37CVakYfIsYvZQYPd7n3hgncF3ggnON7IsWFdW1XIi2ugCjswa4eGvRH9rVBDZKfH1FhNJAj4GVlVPQ4KoD81fU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snKAg8St; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8b32453d838so1245733241.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758265139; x=1758869939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtcgVCi+G898H3JycH7loc6tUgEzYyu4N3/qLFW16pM=;
        b=snKAg8St38Wlg94IVfOpYPzAdzts5B35y5MrCFdCw130Naq0ijWMLWEI4EwREG3li8
         HvO1qmzPHizbUHuDpFPhWrQyhGXyxuJkgRZJ8Ws5j2TFrpQLn5hhRW/vIzscQJUcu0ZU
         wgS2vKdbgQKpjDt3TAuezSUG5ww1H7AZDCx7NJhCNkJhyElhiez0ltnS56N61EEgO0R0
         ZOyxeQnf78518LrpJE15joSIr2YMtnGm4nTlxm4V4JOQMugGYEgvNFPibBBHnTm7vB73
         FUMZ31b9gDQkh/mOCSU0+Q00e/D/QpYup8LDz2yOmYYX1QcjAWksltQ9YIsgG4iVmhs/
         XuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265139; x=1758869939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtcgVCi+G898H3JycH7loc6tUgEzYyu4N3/qLFW16pM=;
        b=ICmzs5YJOHl0A9hYW4/4+wmh8oO83ErdMzZiA6qd5RTFvMYCFVam4PdZ3Nl2evl47K
         +orozRqG8IGjWcOF2kppYM82RGdRNIwI9xONKNxXWWVkmUmOR/qwHD5YD5o73cfhV71Q
         hD0jUMfdi1UiOwBXKTmV02fJiXpmTJZxOsyLImkXu0clPhbxG/v324OVpX2n2JMjbU3M
         LBGbDliNwFnOpnLWvI3SG1eMma6emLTtN+PFxxacaJfb/vM77dfqro3Nj+gGglQ81Ril
         CY7Z5Ua5mpSYS2DTB9BwnzSfUcYNkr/6bj7x3bQlW/aqQ5orNnjO1FqSpc8tx/u4AC80
         ABhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU00DVV33Z6l5rE+VLSebKwbh+pqfD7W3Ypk0pSXksvMzAHLEj1dxBJ+WLZAgE2YnJZDtljWe3OYPi+vro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkdQSg8/FicOUrMV6+TblWUkz+2+l/h3kaX4GCc/VHzByv28qZ
	FkiNK+6arVNERhAHhyO1p4JuikIAU96F1gsAdYfGpy8eBxmFz0deRrUB9VbdSStoYbRyY+Zq+vr
	/UIRyj6NtUAlux0Tb+5q2YfOY7zL6c/oVMjGWGS2n
X-Gm-Gg: ASbGncvzeG/x9+7b8kuMAdA+bB+RVEJlBBkIzRAEVgjT5HeTHxSsfKNJZZSM5tq4KcY
	w0kL32Jb7vIL4BX79mFCAaB3+e8D/3rghBvTGnnY60pAr9Gveh+2TnvPievo+VlBrctcGuxsGfg
	2BY55pVOkCiFl3YJhRw0KCQIa8fHqoUEi/XAEyGMw08bEo5DuYxCs4H9RQAQN21MO1Gf5hPHVAB
	0b5UnUWzbZ2PV3fGxpDeMHT9L1Nvw0XvYiBuQ==
X-Google-Smtp-Source: AGHT+IHk3HVC3jvHLLDRmh37Xu/EchCNrhbpXqT1eVIU2RepMDaci0Ybt3B7Crf5TYbbvxxQhcjhhhXUFlwv46zm7xc=
X-Received: by 2002:a05:6102:3347:b0:529:4cf5:8aec with SMTP id
 ada2fe7eead31-588ec1dd609mr784951137.16.1758265139130; Thu, 18 Sep 2025
 23:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917025019.1585041-3-jasonmiu@google.com>
 <aMr1XAKmyfzM8RCc@kernel.org>
In-Reply-To: <aMr1XAKmyfzM8RCc@kernel.org>
From: Jason Miu <jasonmiu@google.com>
Date: Thu, 18 Sep 2025 23:58:47 -0700
X-Gm-Features: AS18NWA-W3pRg8J4Q0PVvMgsoADaqk7Awe1gJKAjZHyCKtolHE0_0MrSoYHTlwM
Message-ID: <CAHN2nPL6SV_Y6Sxqy4o-mOPZoGYMoWow=KevUTX6=c8JkO_g8g@mail.gmail.com>
Subject: Re: [RFC v1 2/4] kho: Adopt KHO page tables and remove serialization
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

Thank you very much for your comments!

On Wed, Sep 17, 2025 at 10:52=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
> > -/*
> > - * TODO: __maybe_unused is added to the functions:
> > - * kho_preserve_page_table()
> > - * kho_walk_tables()
> > - * kho_memblock_reserve()
> > - * since they are not actually being called in this change.
> > - * __maybe_unused will be removed in the next patch.
> > - */
> > -static __maybe_unused int kho_preserve_page_table(unsigned long pfn, i=
nt order)
> > +static int kho_preserve_page_table(unsigned long pfn, int order)
>
> Just merge this and the previous patch so that the patch will replace the
> current preservation mechanism with a new one.

Sure I can do this.

> > @@ -1023,12 +752,8 @@ int kho_preserve_folio(struct folio *folio)
> >  {
> >       const unsigned long pfn =3D folio_pfn(folio);
> >       const unsigned int order =3D folio_order(folio);
> > -     struct kho_mem_track *track =3D &kho_out.ser.track;
> > -
> > -     if (kho_out.finalized)
> > -             return -EBUSY;
> >
> > -     return __kho_preserve_order(track, pfn, order);
> > +     return kho_preserve_page_table(pfn, order);
>
> I don't think we should "rename" __kho_preserve_order() to
> kho_preserve_page_table(). __kho_preserve_order() could use the new data
> structure, or call the new implementation, but I don't see a reason to
> replace it.
>

Ok, I prefer calling the new implementation, so it will look like:

kho_preserve_folio() -> __kho_preserve_order() -> __kho_preserve_page_table=
()

 __kho_preserve_page_table() is the internal implementation of
kho_preserve_page_table() and we can remove the
kho_preserve_page_table().

--
Jason Miu

