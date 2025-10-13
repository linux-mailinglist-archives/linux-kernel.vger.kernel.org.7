Return-Path: <linux-kernel+bounces-851353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E848DBD63BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C21420FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675B2FB998;
	Mon, 13 Oct 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSA9v8dQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6C309DB4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388279; cv=none; b=tMg8sxbg5uVLP/9JIy1N9QcbHSIt9/69OlAAPNIhIu6R1XDllTBBx5LMKoTUI0+pKNMmvWmZYdI1gGAb+20ibCYI7jvSPKkcPs5Tz4HjR2tbJS6bz/gNQGFKsLUmFCOnTIOKDE4m/D+iAbn95Jb5Ewmd15kJUA1EIzEVtW7b6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388279; c=relaxed/simple;
	bh=9hay/0JIfknGgWYAyMDi+RRa32y7nL7hZHKUlG5JnX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syHy0Ef3UPw6g0KpgRD3zQ6EVjK1blMs41eiTlTN7HNMD+cQ2fKOGUEibd/Yf2PcW3QA9QV4E5NReC2uzUu+6zFd3PiNpZxODjK/kaa95wSY5q57DO4VGcBUNgfgiTnPbPA6Eqx3zHERXNlX27bc0ySW9PaSy/oW6PZNGzB/CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSA9v8dQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f44000626bso3307089f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760388276; x=1760993076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9hay/0JIfknGgWYAyMDi+RRa32y7nL7hZHKUlG5JnX4=;
        b=wSA9v8dQf6O1yYRyuKW3CRU1veMgj6HQEXi1tSKruyHFiieY4baFGRW+QIDkkbxeGr
         mqbNENk94Ch7ocGYsurhvv12j4GXhYCMCJs/WTfSzDMha1voTLKRiSdob+7zYsS1D7Y5
         ond+/0INdY1a9Orwg07aL7Xc7Bs02t3eS5qOsLS9zBmibWZsDh6iTQkmYWFSXY+gz0Is
         CI96hIbLbS3nNoocslWRpS8SYODK2wFXq0uZLbM5GyVRAX3+MgTr9vzACiXszjQ+s9GJ
         hGzIsLrHJx317X+w0ifB2z1On/iGZNbWfCs/snllZfZMHt81boM9oI1NrnJJgCuAMTc3
         gYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388276; x=1760993076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hay/0JIfknGgWYAyMDi+RRa32y7nL7hZHKUlG5JnX4=;
        b=R0W6zUYMY8s++NKqwEPJPhtqfz+N/O5wGItoPh7P8JpudTL4H9wNpnwNk9oWEd9QRq
         lAuBm/u9/iwYa+2Nq1W68UmeKJgmyzj+vR0cGBG3SI3xHeh9lNWICC4RCkQAHw213FX+
         HOPW2rmILa3qHnEVDnxzqaipbBqDNOAMsNlykq4K/B6Wvl5fz92UjhGC5zlI64WwF7nC
         tME4m9zhdTeqNignbtFwHm5CoVPycRxwg0TJdxIJxwqoO7+SMYBnJpZUnrwgbc/lcWp+
         vCzBLzt+o6/y3r+3s59puH2r/URwGQP3JdZUeAe8yca8Q08C2h6m68vKT0gZCoau2gGQ
         L3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsxUDcEhc09RiTB6XG/tshyLZBPjyzlWBHP8EGvm+9iyhRh6jzlt05MpKDMgJGMxztkj7qy6mnZTwwV+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNfWh2RP6LU1QR/IVHqUeSYqGfumjzxE5Lsz/WJkDIlfbi0zR
	JOmp1+FDuJZDWNV9pWwNCdDGJ6kuKpFvJsi1fvQeldHQ3kySbO6RntPUpZtn1rJBEF4ia69VJ1o
	Odzwn8yfnw+MDfGwlDl2RJYxl5U/Vj1HuHOoY87WV/6SVFFEa4l/pmsoS
X-Gm-Gg: ASbGncsfMK+44xPXQYe3/UDAwCwgzXG7NW9PlxyrjNcIwa8hLNRyMphRtZM/FZFiQeb
	qSA1jLIHfm7e4bsNBUJWiFHxSpHIRUnXibsiOLKZBEh8sbij7+/i7v1o0JHk/ftJ+VFyJ9bJPvB
	U3CyCAc3RB+zLaIhVlF52ZJfh6XsvpP+rBGJlHKTgiflHQd4+uTBTzdE8GgxRiQ5UY4wLNNht2L
	EC90mt5Qmp8oQXf8a9ivJuntCaV1CR6dvOhg7jS3ltKeuLdcmUYl5UMTS2SlShkUA/BIGYWsg==
X-Google-Smtp-Source: AGHT+IH1jaLuUviRfQbDoA6NkOlm+qkv87OVo2UlFWcQ+L0Qmlm8gTytxE7e1laTJS5cXlaHj5g++60FMQSaieI/SWQ=
X-Received: by 2002:a05:6000:430b:b0:3f0:4365:1d36 with SMTP id
 ffacd0b85a97d-42666ac9d80mr14319200f8f.16.1760388276152; Mon, 13 Oct 2025
 13:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <20251007000007.3724229-3-jthies@google.com>
 <aOZgy-ngtrilVQ5N@kuha.fi.intel.com>
In-Reply-To: <aOZgy-ngtrilVQ5N@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:44:24 -0700
X-Gm-Features: AS18NWCU9ewVmTl79PE142H5oFVAZ-jo9n41HkuLJQx9P7yXDul6gDppIar6RSw
Message-ID: <CAMFSARf+PMOJHc5FtnSB0hCyGVnguNrTada9RuAba4Zy4XCm+A@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: typec: ucsi: psy: Add support for DRP USB type
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Benson

> Do you really need to iterate through the whole list of pdos to find this?
>
> The DRP bit is guaranteed to be always in the 5V PDO, which is guaranteed to
> be the 0th one.

Thanks for taking a look. This sounds like a good optimization, I'll
apply it to the v2 series.

