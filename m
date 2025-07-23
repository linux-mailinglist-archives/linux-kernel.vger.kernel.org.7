Return-Path: <linux-kernel+bounces-743019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD0B0F993
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705EC1C805AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8FD221727;
	Wed, 23 Jul 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYmwN/F2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209BC2E0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293008; cv=none; b=tgW7BPvNG2UPrGFzuAn8aplPpIpvrLhP9RdyrlmYLysksG0SG/zaK97mC10RM3+R0434ISOJPVRXknrTKck9nG6hC/pnBm5b/ABfVAIgJobOUWjRpWq0CPa/nTGGK2fjqanuCsAmfk7Ej3Ufutr/GvJlvDcZVvGrbezLd/4DM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293008; c=relaxed/simple;
	bh=N3CjZ22bo998Gf96yMZtr59wxIw8Kk30KdGo+Ax6K5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTwez9h5RevvKlnwPRX7t+4ySgc2IM/q+z/qUDaDfTw3f0AXGx3cX81BWww4uN0GeEmNTFGrzx5cB8ZAxfuZNWclgFSuabGkXY6/nxQe33l+duabqGdEcRk8pSGW+FLeUDx1yjaSmc+WErXk3tnMh/ICvxFmEiOg5j9uhI9fwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYmwN/F2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so999a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753293005; x=1753897805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3CjZ22bo998Gf96yMZtr59wxIw8Kk30KdGo+Ax6K5M=;
        b=aYmwN/F2js5d8YFEXNoKJi8SfC3V5fydSeiDCvCDzMlk14KfSOSqRkQBGeoW2DNr5B
         K1BHtFdD0seLZhXwwKYC8EOffVollVD2A+RmJWEJFXdsJH4n0y8JF/AKdkARS93iRLf5
         Mq0JK1XxKPmsyYihwTqkgsctqvoIqjh5dAqZYNcK8GIaFNzk4ZGlCrCNCX63Q7m89xRC
         TAn2UkOkIEmkL2emiIRQeoEJMnAJpw8dkzApKpQidVxJYi8hNz7mfX2UioxdKcb5QYu/
         t7B/oUqZJT6pI77B4uSkiqqCKzW46ELTFbXjKMwo/UqjvY7s7Ac2ircD4p52J7EMvt70
         0VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753293005; x=1753897805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3CjZ22bo998Gf96yMZtr59wxIw8Kk30KdGo+Ax6K5M=;
        b=XhspWZTUn2H6GMReSEUt9TLeYDP4i40JHlC29ah+IfHghduAc0tPr+QB7TiCcmLBcB
         4KTgOI4B11hzqRAJtT5EsLI6PyHRpYGLD3SAPJBLhpnBJSyA1bWYGGawBXhEwfmnf59v
         w55P8EvXdV/IwL60OgTj1KJReFGrl6cjo1HlyWqzGf9W2bEcERqvt3vqMBKQN5xdCN4A
         fHbDHoKV4BdfOcNgPm2t10GOilMZPBjHim4kEmGxk2XR2g1zszkenTJ/eGk0grKSm8HR
         NK9D7BbQWS+9+z1pRr6+e2Qi0KlYwoAiSjIbcGi6WVkVJm8PYjpzFhyugab7Z7XUyZvz
         M8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRs9xa3VmEhbpdkClJl8dLCF2GiFSQVXF2oRbBbocDDqGvvvTyqJkfO8Orirp6ZvZtLds5bW/vLmfpvco=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGDykYHrHu2ckE2Zf7t875+EK88/aA9fihB4xt0rUMMwRfIMe
	IGFNB+ycXoBNq1KBXjzrBzchkYQp67LwrKTFbi3LBcxBYXyWxeNWaPMr1k4jny6fE2EXoAwkJGk
	+gzQ6zaVEAgbB3H8B327U3lM8Ji+loom9aZUjRcu3
X-Gm-Gg: ASbGncss0Gg3MKOc8p+Ixl0E8/bWW43N7hrPUR91lmapSEuJUV//wc6Yzktg9QJDPj+
	t7uwOVrY+EqHGdGOGwyZGHAnC8G3ClLDjb3cTB30EHYh3pkZ8g9sGVQQLNje8/5O3WVmWE6mIEn
	BcVeF8X2WE2Asfjd/DOewy5pQc5aCkb/EW/WRdp80jS5kTHSUQ+Lrf8V6AW6qHDlZHBLM+W57DA
	cnkF9lLioI96BNh6XnwpS3MyL/m15PalMo=
X-Google-Smtp-Source: AGHT+IFZndI4SLY2jTFfc7anANksmXujHTfbPGok6SPCPQiLXDZT+bTXYZL7u6XX3OLnry7gojrC+xg7+iozT5iiYuw=
X-Received: by 2002:a50:ab0a:0:b0:609:99a7:efdb with SMTP id
 4fb4d7f45d1cf-614c4e2d68fmr959a12.2.1753293005107; Wed, 23 Jul 2025 10:50:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
In-Reply-To: <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 19:49:29 +0200
X-Gm-Features: Ac12FXzJzTto75PHjdORYKleZSwPq9-F8zjWYdNYD8vo7sV26qM4zAkWjh6UImY
Message-ID: <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 7:32=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 7/23/25 18:26, Jann Horn wrote:
> > There's a racy UAF in `vma_refcount_put()` when called on the
> > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > without sufficient protection against concurrent object reuse:
>
> Oof.
>
> > I'm not sure what the right fix is; I guess one approach would be to
> > have a special version of vma_refcount_put() for cases where the VMA
> > has been recycled by another MM that grabs an extra reference to the
> > MM? But then dropping a reference to the MM afterwards might be a bit
> > annoying and might require something like mmdrop_async()...
>
> Would we need mmdrop_async()? Isn't this the case for mmget_not_zero() an=
d
> mmput_async()?

Now I'm not sure anymore if either of those approaches would work,
because they rely on the task that's removing the VMA to wait until we
do __refcount_dec_and_test() before deleting the MM... but I don't
think we have any such guarantee...

