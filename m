Return-Path: <linux-kernel+bounces-805342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C2B48759
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E9E7B0BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6111C231C9F;
	Mon,  8 Sep 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLDQ1NEy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67EA54262
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320535; cv=none; b=irr4aMHeo3fA/ykmMPi6wyxbDEqTdywpxphnaeD7fZX8xAdFWlYVBePFoQJoT1DIXqTnDrMaNYhPDG801JygmSLPLQ5AhQIvQDggPrEg+1QWCFKNP9IVU5yoQwc+YMYRtemGBm7J0tB4ZMS2Xgcl7qNCUjBlWNK0zs16maGBtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320535; c=relaxed/simple;
	bh=ZnYCJMKYwkJMI62EwtXBZYary+QBpsPo9LP0zljZ5/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heIJ88VLy/Kqd932OleuwDdGM/kwxJ1NZz70JqbiFYbKvuEZaHn7mQ30qqYvUwHpteY9ifAyOC6EQ9XBNMYGEy88ToHrn0b0+0IbjXq17QQSf9ic54+MTjsrIStY1pKsKWmAfydI4Etm7AMHDzcnm1wCQRaD1eS6i35jEaTDgA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLDQ1NEy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757320531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZnYCJMKYwkJMI62EwtXBZYary+QBpsPo9LP0zljZ5/Y=;
	b=ZLDQ1NEyklDAcnZwnky0v5QUQ/M8ryDJVXe2dEbqNWo2mjKXZ5lbYvYzy6gLu67X8dB8Md
	/XhXnN1JIk8gXiJGabZ1J++jEM/MOAK1ifzyqnjnsnfo34cpvSEtBpzLugDJZkLKWxM23Y
	ADfwbvNFSe9shJZdKlWhmpLSAhPW6vE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-FOPd8rvAOu2ITNrGQaeIeQ-1; Mon, 08 Sep 2025 04:35:30 -0400
X-MC-Unique: FOPd8rvAOu2ITNrGQaeIeQ-1
X-Mimecast-MFC-AGG-ID: FOPd8rvAOu2ITNrGQaeIeQ_1757320529
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso27492255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320529; x=1757925329;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnYCJMKYwkJMI62EwtXBZYary+QBpsPo9LP0zljZ5/Y=;
        b=JKFAT7MEvMcBj56eee3XtppQqoXQcfUTkCP8xrtbbj7UlVF/h09jppq2o1sc3HxFqD
         K6ZW+GdbRYGjVlMY4n69foRqYpQFbxLv+IXRrBwEOIFRRxym71u5r+QrHQE3WxlljMir
         vdRhDoImN5MVu4bgbVtF6XzXH5BXE5u/LJPxOyTCP7eywsRKr/dyqeSA//a8scvWvbm+
         0P51oazKW49PTqQmjYSe+lFECElYtEKuTdIJPD/2iLAivFEWDafF2SFdsyOl2k7AAuwv
         yoha9G7bqv8aNMptWFZ1h/eQMSR19e8iU1Rokz+jL7EuCN0dQvV6d+PEXWkKv5OtG4uv
         C9Eg==
X-Gm-Message-State: AOJu0YxZpOm9H42/1ykubVhWqaI2UJ63Zm3IcJE3Qq4VOTNSjChQeFS4
	kHtPL+tgAyZrVBeeVP8NqTVtdCWVwpu3rCS20ZCaW4t6Jxr3mSE0DcWlJYlsGKEXwCY+zL62tu3
	zerM/UI6Vyanf6gRGmcXqbnvwRuCaBXFmDLaTjKT4xxx8XGQOcM9/Z67YpsPywWr+3UnEQ9wOQF
	ON
X-Gm-Gg: ASbGncshkDD/xoSPTA1kyjThM9cA4KaVhZNtn8oPpmvfU7aAwL45eEdfqRohRCqR7fi
	CHA1thuzRvhwDdVTO8A+p6p8Sj0UE5Ea92GQxaZOdowSb5M7hqJ3K8avbqroiM/WjS7zHRSbyLx
	QED1Qjttw9dihGpOH9FAftJuDlcCGuMwQzI2XaNzw9otGDt9THhf5BwGgHBrnd97OBYnTIy6c1Y
	pOf5TghdOndhU3kyvxSmmlB2J5N5eZlF6JtnqcxEIGSRGo3THnYMn+x4VEzXID1i7MAUyucDFkc
	DgDJUbsl9L8foB5/XSRKxy06vrnOP8JBNqj6msN/PYWWXefxMOffDWYhs+4YxtNftA==
X-Received: by 2002:a05:600c:8b23:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-45ddded3e0amr59944585e9.33.1757320529057;
        Mon, 08 Sep 2025 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBVUXwwfRKdHI3rwn9fiHm9aND4mTEXGTMfnukmw7mQSSgnZSlt4eyx7PfqAw29k3UpUD/aA==
X-Received: by 2002:a05:600c:8b23:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-45ddded3e0amr59944375e9.33.1757320528627;
        Mon, 08 Sep 2025 01:35:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd8c09fe6sm59078525e9.9.2025.09.08.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:35:28 -0700 (PDT)
Message-ID: <a95a06743850f85b46dca5f8d1181e73ed70519c.camel@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long
 <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 08 Sep 2025 10:35:22 +0200
In-Reply-To: <aLbm0srwDJVpt8cM@localhost.localdomain>
References: <20250808160142.103852-1-gmonaco@redhat.com>
	 <20250808160142.103852-9-gmonaco@redhat.com>
	 <aLWUkpKgFFVr_TEx@localhost.localdomain>
	 <d001f1bc9a87e031cf4f8721d6843013c766c28a.camel@redhat.com>
	 <aLYMA8niL9Uxhu7G@pavilion.home>
	 <ab9348b0e67f36dea92922bf76aadb7fe9d1667a.camel@redhat.com>
	 <aLbm0srwDJVpt8cM@localhost.localdomain>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-02 at 14:45 +0200, Frederic Weisbecker wrote:
> > On Mon, 2025-09-01 at 23:11 +0200, Frederic Weisbecker wrote:
> > > Right, Thomas didn't like it, but the organization of the code
> > > has changed a bit since then with the late initcall. If the best
> > > we can do to workaround the situation is to make the CPU
> > > unavailable regardless and then undo that right after with an
> > > IPI, then it's a good sign that we should just simplify and
> > > eventually check tick_nohz_cpu_hotpluggable() from
> > > tmigr_is_isolated().
> > Here I'm a bit unsure how to proceed though. We want to fail any
> > single isolated cpuset that includes the tick CPU under nohz_full.
> > I can do it directly in isolcpus_nohz_conflict and that looks easy.
> >=20
> > But is that going to be clear for the user?
> > Can the user even know what the tick CPU is? Besides /assuming/ 0.
>=20
> You're right the user can't know in advance which CPU is the tick.
> I don't mind if we prevent or not cpuset from allowing to isolate
> the timekeeper but either way, a pr_info() could be helpful to tell
> that either:
>=20
> * The isolated timekeeper will have limited isolation
> or
> * The timekeeper can't be isolated.
>=20

As far as I understand, we are now decided to fail cpuset isolated
assignments involving the tick CPU when nohz_full is active.

What prevents us from doing the same in the isolcpus code?
Or at least un-isolate the tick cpu like it happens for nohz_full?

The patch currently avoids the tick CPU in the isolated tmigr logic but
allows it anywhere else.
I believe if we are changing this, cpusets and isolcpus should at least
be consistent.

I remember I went down this path because it was mentioned the tick CPU
is allowed to change. Is this really a concern when nohz_full is
active?

If the tick CPU can change after boot, we would probably need to track
this change either way (in tmigr or isolation/cpuset), but it doesn't
seem the case to me.

If we guarantee the tick cpu is never isolated, we can get rid of the
tick_nohz_cpu_hotpluggable() check for good.

Am I missing anything?

Thanks,
Gabriele


