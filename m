Return-Path: <linux-kernel+bounces-735272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F16B08D10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15FD3A71A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32372C15B2;
	Thu, 17 Jul 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSVqWnuN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F89298CD7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755788; cv=none; b=YaTZgEH8oUcZs0FTws43gx0UPmt+DfeFVQbTcwii6IoatJQQttYTKHa0c5cdOx/+o/5c/+be12XCH/a2yFdbbEHvvZsQi9jS3pW1KBkC5gj06RB7xEAUoVuSc7ED9HXbMOnmu3fxxsVzZX/wUhnnLuorCN9xPCtLlhcS1tOaB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755788; c=relaxed/simple;
	bh=Wtc/lxX5coOhUl/u4HrUWPOM3H90E0+70wFaxMF7Z0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmIYpbI4FVGaPAWznygcmjlcLf3t9xD9v03Y6D43Rldx9lfscgStWezjNZJcOUhZdGA28T6IjGO2JgtfCZiKuKFyctOicl/EB3mNPpALU+hg33x+pPNpG2PvgHQMREqrfz4/uMY+QqGtzD0ZXUlk6TvB84nR+PcGWt6TDzSOsMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSVqWnuN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjmlDzzaGZ9rTLi5Kx9j22e46U0IOmOFefScvfSSAnA=;
	b=FSVqWnuNcPvNnKnY3N8jMHbCsdEEo/ACy3UY6IH2IkX8F4nq597oJiM+PojXsuZtNNLSC+
	9Aoo1/IQ/tjIu+PBwxvTMzPkzXUQ+PDkkVAAh5KpoXxaI0p0R40ToneBb0xGSpodmMZWNb
	YvqFoFBAVNHRyj+niGv8Pk8JJW0bOIo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-AUo6EBujPty3tnoEz0RDGg-1; Thu, 17 Jul 2025 08:36:24 -0400
X-MC-Unique: AUo6EBujPty3tnoEz0RDGg-1
X-Mimecast-MFC-AGG-ID: AUo6EBujPty3tnoEz0RDGg_1752755784
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e8bce40677aso1353847276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755784; x=1753360584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjmlDzzaGZ9rTLi5Kx9j22e46U0IOmOFefScvfSSAnA=;
        b=Scz7Ym05bM4jNAsS+3t4DRfjIVXCHdexj5X0diO2NfD0vH4n4d4X268JNgLLFf/97E
         vi+5RkdaX/+X5MIv+MaAMY9QcozPalYqk4vcOKe0eyPGXkbzu2t3U7H+hyMbCfkWmVTf
         lXjvPDe3HLgFwmTqn0C7s7i3UwhxkVNx9lo8aSo9FDpvM3ZHaOPJnal20LOb91Tk5MA8
         KqAAa0VnAGKEdqvUwmIBGV3EwFsgVOPNmGADczhY4MXXbb/jrS4th9dNK/nBnM8taodD
         H5FiErEomBAcYrM1fpm6IFf6xOg1Z+ANfT7Z1oJ6Jl2xtzMd/LMYuM2XfiAKyUPRcSU3
         3xmg==
X-Forwarded-Encrypted: i=1; AJvYcCWTMV2UNc1bKOmhk2xpmXP7h3ss7+6iN+8ChknB9CjrpMGaUrPkEQuX0BXg5cp+BF7QWiu6yhTPXkJdHSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOgvNKc6ZkvwDbjykzrtwBTmB/THRJLzHX0iieyPrawgEYXzs
	KqTkaCUJTsOovb5hSPCvJ9JvAbhMxG4+lbyO1uhdik2KfNFRCkz27HMLq601d47yqtAtNzbQBIO
	HdFxv/aApqtQSW38JZu2gBE878TshuIB6guZQqUfb5B3E4SFxu6cEEgju+s2jGSvzq90SJJi4yJ
	EJfrlSAn4yE5HpbhtnQY5xZTnFpqXjQr0QEsK8DeKj
X-Gm-Gg: ASbGnctvnf4O5Xj6GetjjApJdk1Ov7gT1KYQ+2XKmWEkHmy5Ydn+3d4zA2WcYKFZfbt
	KOAn+xkgZkIAaL4Kdt6+YnaK4xpTH/DGQqfabIiG4NxZC+oMg8cRvG6quSCJggJZQv9u7ctYGp8
	UGsW5EmTepkndPI33QN13s
X-Received: by 2002:a05:6902:248c:b0:e8b:bd51:f499 with SMTP id 3f1490d57ef6-e8c56d62b9bmr2917306276.15.1752755783727;
        Thu, 17 Jul 2025 05:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmzgzsBFJaqPrJKGrgO7xxomhF5mMyGas/UFwKiQJ4GPBsQUpF11VlQotlrI8QAyk5b0oSkOjaa9152R8A3Zc=
X-Received: by 2002:a05:6902:248c:b0:e8b:bd51:f499 with SMTP id
 3f1490d57ef6-e8c56d62b9bmr2917267276.15.1752755783217; Thu, 17 Jul 2025
 05:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717082741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250717082741-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 14:36:12 +0200
X-Gm-Features: Ac12FXzyUippo4ZuOkqcubjMy-uJlrmKG3BS-ASFjib8nJb-gGmmbC75MdR5_BE
Message-ID: <CAGxU2F6Jt0zT==4KfqCnC2nhptypZaEjOYt7ufeYDWdm-c3uJA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 14:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> > Hi all,
> >
> > Here is version four of the patches I previously posted here:
> >
> >   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
> >   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
> >   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> >
> > There are only two minor changes since v3:
> >
> >   * Use unlikely() in payload length check on the virtio rx path
> >
> >   * Add R-b tags from Stefano
> >
> > Cheers,
> >
> > Will
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Who's applying them, me?

It's pretty much only about virtio/vhost, so I think yours is the right tree.

I completely reviewed it, so it can go for me.

Thanks,
Stefano


