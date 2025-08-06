Return-Path: <linux-kernel+bounces-757583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D3B1C3E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0FF16A4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272328A402;
	Wed,  6 Aug 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpLxhWyW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F781DF256
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474223; cv=none; b=PQVyw62PqBgScoLpbx2iFrgdzGsw8aHLWf2NsPhbZZ12zXQghe1oakUaBCZ8/4CGEeigDO+6YN4smJbtKDGfZ+7USptrqDckDTM4zFdN7i2XXZBHF3/zr7La58wfjjyvMyZNlgXhVlQg+UAWLzQsBchD7Z7dBZuKu2yM4d8U3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474223; c=relaxed/simple;
	bh=UnRhCBGz/g5M0sDRDevsbQoDZqubHqeSfzdgXcUdUSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F34jTshX5FV7Lr6B8qsWJlUuKr5qzXoLFRAOOKgwn3qRDDvLuP792DBF7yCwR8Z6vojy2XXRA4GlUUC9rFhK9wImcLKl+s1ZP4EeTTrVmtUgfhyEBR6bG25Sy9ojvzBUL6QqV7AKsHzj3E3irSviX9jn7DqRTb2v0Dal7xzafW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpLxhWyW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754474221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnRhCBGz/g5M0sDRDevsbQoDZqubHqeSfzdgXcUdUSU=;
	b=DpLxhWyWvKk6KSvW39PraU/8DUTauEI+aUC96gGUFbfQjThLUBe3cAwqK6RhEA9aBhNcSO
	M5EPqLphNPDDHu8oePlpvPytak4L/JUdCfwzq124L2JX8H1ILfvELoZ5i7cydfVxsFIZne
	PugJrFLsDNC8+FkktlsccIoTcI+TguA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-wOlEm1BNMOuXS81yNaiZFg-1; Wed, 06 Aug 2025 05:57:00 -0400
X-MC-Unique: wOlEm1BNMOuXS81yNaiZFg-1
X-Mimecast-MFC-AGG-ID: wOlEm1BNMOuXS81yNaiZFg_1754474219
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7806a620cso2927153f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474218; x=1755079018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnRhCBGz/g5M0sDRDevsbQoDZqubHqeSfzdgXcUdUSU=;
        b=loubGves3qodkERlpX4lZOCySDmAUWkUjJbHuZAzvAD4XJ6SLinE7sMvIjGb95bvIt
         /5JlWHaUem/CFltcbq4oCOkJvQgCPfD4iG2O9A1TOrMb+k9E/2hYd8cDJkMsHKeZF9BX
         SDARRuz1ncytbuE7yPYIv29UHInUPD/2XwfXgQWwrabqVRj5cFMyIiCbRvfDM6eyg3C0
         2A876cxLWQd9alEkUPVqg5Xi8epqNsdymWjl9HliiOVl+QB/KimgKWWqnEfG2rsswNxb
         i32wS3xJikzji2OZIAH0HChxXhOozGARBfJJzfO+fmbrkhpyihFDJRVEmJbyGwhb54TE
         yY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmeycitIQJODPd/pFk/VrruHf656EDVPoOpoCLDzUidzIb55E0/+zDnsMFKVY5jswmVbEuvcoepvhkc5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkYBUiSEKEWjlk+pdo0qAM6/ei+MvfB7GMlu91pulFIki1BGq
	4xfTY2yfH63pLdNBwmlLwVW5eTzPwdIQFCv9AB1JhPw/jyCkMHc0bij1ckqRNfnQaLri1i1Y58T
	MRGMERmaAeaq1CXAqfWTU1uPSGaepvQYx6BT6mv+dxoVP3bLsVs8qE1nTGsBO+PxW90KIFp1I7v
	BOysDoia8SpQofKIapAXJJxy2baYm/UBritz8KmkFfOPqI/Gpm
X-Gm-Gg: ASbGncuakNPpiuOt2gvXaaQscSgzIBj+5g2qixl745eigz4YptsIbdc/yoMtbIQwWpl
	C3WUXJMAUVhpwqM1eEqKXg6Vx2wzpF9H+iptA/ItPgLobV8Kd9WR6CZYyr60923dob58+6M/jEp
	LI3gV1M0aTv+HdYOuvHRdJBw==
X-Received: by 2002:a5d:5849:0:b0:3b7:92ec:68ec with SMTP id ffacd0b85a97d-3b8f41bb8c4mr1730023f8f.14.1754474218395;
        Wed, 06 Aug 2025 02:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmkIlZiBIO0pxwuhv5ZEuhlp3NbgCJIQMCznSJgwMIdEJJHMlTE317CHbrVdWmT1WXyuHGPX1pWe6egu5BZuE=
X-Received: by 2002:a5d:5849:0:b0:3b7:92ec:68ec with SMTP id
 ffacd0b85a97d-3b8f41bb8c4mr1729994f8f.14.1754474217980; Wed, 06 Aug 2025
 02:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
 <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
 <CACTEcX7oa+Shj=uYiRMoWpng+RZXDeQrOa-VTRmzVVtXJMCgLQ@mail.gmail.com> <CACTEcX7hsRkzYEBg4pQd5s36p_ZXJM=dtxSGmBjfkt5sWrXP8g@mail.gmail.com>
In-Reply-To: <CACTEcX7hsRkzYEBg4pQd5s36p_ZXJM=dtxSGmBjfkt5sWrXP8g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Aug 2025 11:56:45 +0200
X-Gm-Features: Ac12FXxUD7IfHIB3LF4bE0A3e_MF7VVLU9X5HEvxDOG2SUB9XsZW8ohxIfMVMqA
Message-ID: <CABgObfZagg8_w100tEnbU0_adUWPcnQYzxy8aAyUqVASjxWujQ@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: Andy Mindful <andy.mindful@gmail.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, ville.syrjala@linux.intel.com, tglx@linutronix.de, 
	Christian Brauner <brauner@kernel.org>, Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 10:40=E2=80=AFAM Andy Mindful <andy.mindful@gmail.co=
m> wrote:
>
> Hello,
>
> Can somebody advise how to properly bisect issues in linux-stable
> repository between v6.7.11 to v6.8-rc1 tags?

If you can test 6.7 and bisect between 6.7 and 6.8-rc1 that would be
the easiest.

Paolo


