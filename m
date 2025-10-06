Return-Path: <linux-kernel+bounces-842766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F7BBD821
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F45A3B6FED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034622101AE;
	Mon,  6 Oct 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq1RXggk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812620B80B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744384; cv=none; b=Asw3AHo8odyUD80nQ/mLD4atiCBmDjFzcPnuQpyexUduE0INCSbQm3Z4QMTCExQZm83mLeUTM/p5vMmyngnFaCUBJ/Rk1b1jJl/Pun6wunibhWxoxk7YJb9YJqhvPolb5YxQCo5hAgEJDgK9iv93YkPwdVJvvgkpsW0VJrWXXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744384; c=relaxed/simple;
	bh=bHqclwyLkUNjJLc1hzYctTC+iEb5fEGxWqRMdYUGqtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVxU5MJwmw8ZvgJ8E6UPl+ArvxE0MeinJby2KSYhCpKVXbLZmByPxU0j/6paNVI6Kn7WldNWXXBcGTDoU0FMu3mm0+pcspfc7FpqQxz4Uk5ttKWD3f3Tjm0J8T/a0NFwcNgkzLHNmS9tZBj2b1AJpbRUZ0ydA+7oKgkSdcPBL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dq1RXggk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759744381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxh9Z2NaPYtIW6LVb70fTOamcBkA8Vc9TSWtwP/uZlo=;
	b=Dq1RXggkoQfNlRxC1eI83nwHYoFDGqmfw2+qfgcA0VxJHHcuA1pwzcJqU+IroaVStiZy/w
	NTeOGTzsxc/MctShcgZ5aZZzZjM6XcP9LuVuzzlw7+TKcKuLg44B2OnEi59bIbC6FMd0Ok
	IShzgbNSvj2DIWNz8qIEE1L3IjczDlk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-9IN6v3kzPreJo_M8ZoHMHA-1; Mon, 06 Oct 2025 05:51:16 -0400
X-MC-Unique: 9IN6v3kzPreJo_M8ZoHMHA-1
X-Mimecast-MFC-AGG-ID: 9IN6v3kzPreJo_M8ZoHMHA_1759744275
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afcb72a8816so378460966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759744274; x=1760349074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxh9Z2NaPYtIW6LVb70fTOamcBkA8Vc9TSWtwP/uZlo=;
        b=KboXH48ODcx4XEiefEBiKzCF0/VM4UpGm7KHYXIb9blBE5QGM7IP4fpvzLeuw39H59
         DAHD3lKbWUcvBAGTSgngrjhv+C/ykr2CCA87GoUiFsAzjWsANDkxfHjIu4jppdsvifF5
         migVA5kWS+l+Qr2qqRVY03V+/sqmwp1ZnEcBnfwvTRosXXNehCAuhHXCsihaPuXJI+0s
         yQNcmo/iixcvUj/qxUF/Riq75Bu3FAdJMjvWMOn04ojeeN7XJUTWRE9YHsWIenXS4GM5
         YosrmkkD24+8cZzcnqWlfdvStFAhfDwZGnNzISDQgzu8t7mchIzBPU0ltMxvTIrFzDt3
         cVzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQrtpTx8GDVay9AIQ43xo5GU/4rilG09EGoIb51QvJcox5+2dVVvEMHYwvHoDmcoIbPcWIZPok3ftWV/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VzDdelTPKjTeD1O3V2uA8LXJvS9wxt3yki9+EmOrUBp9ndAY
	QJZfByuM6FICLUsjzbh51YzTEo0083y6652rcoQlqA5Zl9otgFh38LRTDWiGPYr/zX4PU7e539C
	+4t5WQn4in8h4Payo7lTeWhUWhNH1A9CNxSkcxeYsZHnO7hv3kfq/lpnLkgqlzLlnvQ8CV6Bah8
	qbvt+p5FeaXn5Ywk0/M7TFwpikWuK7p/wTwxVwWN8MF/Eo8J/w
X-Gm-Gg: ASbGncsVMqTgJJbcttlg9DG+aS38UZdaWbsXcra+gNH4z+YxJJlFxPKs5PW+BVCY+af
	WUfjwVdz+6/Yx16QXWkHR3TsSU29/MD49b+yFv9UIwTx5PztRWerXSHntcHTV4xiF2ZuKmvWSHq
	sfbF3LsuQrWwtmN970W1Li33wUztOYaUYPtqo7ll2Ps/WYKVHo9pnpCTRa1i0=
X-Received: by 2002:a17:907:86ab:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b49c3d753e9mr1594129966b.31.1759744274496;
        Mon, 06 Oct 2025 02:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUSD2bCGjfaLibGZkbwwbVrVW0T4OZZ8ueWgxk9+Jscatm7Wk4WTwtLGrqSVSARsQZzylgAei74Xb7PbDKJyI=
X-Received: by 2002:a17:907:86ab:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b49c3d753e9mr1594128366b.31.1759744274122; Mon, 06 Oct 2025
 02:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165919.3362000-1-rrobaina@redhat.com> <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
 <CAHC9VhSi68-i8om4VYbxRsrK7xpVL-NJy89e01qsa5WTT-hQFw@mail.gmail.com>
In-Reply-To: <CAHC9VhSi68-i8om4VYbxRsrK7xpVL-NJy89e01qsa5WTT-hQFw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 6 Oct 2025 06:51:02 -0300
X-Gm-Features: AS18NWAE2IYvrD6g_3gTlP4iL6cMvZ48OibF5PWMZ7lVDeVlaCGvMRgAbDQeWkA
Message-ID: <CAABTaaAW_a7_8WD8hsJw5X0q6BKcy82pyigr0HJHCZn0==KPTQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Mon, Oct 6, 2025 at 12:21=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Oct 3, 2025 at 11:50=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > Hi Paul,
> >
> > I=E2=80=99m curious if you have any thoughts on this one.
> > Please disregard this email if it=E2=80=99s already in your to-do list.=
 It=E2=80=99s
> > not my intention to rush you in any way.
>
> Hi Ricardo,
>
> Your patch was posted right before v6.17-rc5, and with only
> approximately a week before the general feature cutoff for the v6.18
> merge window, I didn't have a chance to properly review it before the
> cutoff.  Rest assured, it is in the review queue, and with a little
> bit of luck I should be able to start working through that this week.
>
> As a FYI, the doc below describes some of the basic process for the
> audit tree which may be helpful.  If you lose the link, it is linked
> off the audit section in MAINTAINERS.
>
> https://github.com/linux-audit/audit-kernel/blob/main/README.md
>
> --
> paul-moore.com
>


