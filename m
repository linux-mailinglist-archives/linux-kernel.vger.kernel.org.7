Return-Path: <linux-kernel+bounces-737265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88520B0AA11
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47400AA6C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EE91E98FB;
	Fri, 18 Jul 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7CeTc2X"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F317A2F5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862773; cv=none; b=TlZbZ0Q7OGo66QtwizvB4jXykMj4rgtc5Nx+xdQMhUijOhk9SLx4joNEb4FO3jQ+H156bxaSC29Ctrjg3Kmu9qDWDUgM3RB10Zd4HQVqZlMxWjKCFUaYBZGhh7StBtyYge0CpIJRQKERmKD76yWMCBUWAMa3leyMbWmo3YRzgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862773; c=relaxed/simple;
	bh=34FVS4kZyUN8z0J64LY+FYLvw4SAjrJgfg+9PvBf/bc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tQA4R0ftoWPG+ZtGCKB8AIl/rAwFBP8hvJGQDf1WYlGxEYDMN5jzRFF9w9lmfxq3f7MmnGqQAVPN8kpdgE7VeBS6MpIJ1DyUcAy+6/sth30ZkhAUSlYXR3FA1i/ZQX+xPh+iwKiRqmL0FvWh10/pMA7oSUssC6ltEUga/6C7FHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7CeTc2X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so6309895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752862770; x=1753467570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZoxL9CcSzlDoFJJH0NKdHgkv+I5OO5RtmkFXzepTuw=;
        b=O7CeTc2Xhi7SU8dUoY0EqfaKV9lxLSAHg8QgXcAVsbipNnAX9RncuipZWMX5wreAYX
         Ym1xG3PArpkG4Wg4dIlo6mgUPd0prM6ruUFihlTBYBXoaG3MnvTSoq6l23ovNXl+LGtS
         VlBI/EkaASnfKZEpMJL3ffaDS9FxdNk8PAoQbqdYXJlvzt2PJ3eiczLei0QKyFWYYRkU
         4Sl3uV5chpw0utrIFTIx3yHDUe6s4PV1xxYBxJGI7pA5b3u4ddvsjpTV3ZejguDUUHfx
         3kr6Fh2dJ2nvuDbTaQxewBaoj2rL3Ih6pQTTSP6A4Je9hKE2ivkHyHWeYIrgf7/06frF
         S0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752862770; x=1753467570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZoxL9CcSzlDoFJJH0NKdHgkv+I5OO5RtmkFXzepTuw=;
        b=bFkoT/ENd0RxpNcRrIaJUdLqP69GGe4IzuM37wGUhapyTtzpDiTdh6cCtB94EWZEXE
         +VHWHjCpQvaO+8DxBfvO5gcCPHxWWvEvu/d7+/XGWl3iNejAloaQNUL5C0jOkf7KUetA
         bBpMVQoHRvMBnI7tftnwoQlSgI4p+4DtlilcjMlx/0L6uo1t/B7p+RH4r/xTIzpOhNuS
         X8R95JDf4A8wOlwc/qik/XSrGGde/bO+Y5SYbbv3yPDH6kt1NrpkKF7s00PZ2PVvB+i/
         aYkENwaJWP11aK0SKRvc+MppeECzuYYsrdXZvJCmBpakEg7+DWR7c3X6AAWcPzSnkFG3
         SVmw==
X-Forwarded-Encrypted: i=1; AJvYcCWM/vzPcFe4tN4naRJuNnkQrlLxpyD9N8r4FYS8lKftJjqM9ufByM7iz++MZv+w6ISnuxVFequJhKicV+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7D0whIMFYHMDvm+lgzazptnvxSxhbWesvx/2upwpfhgTjv2us
	jgs7mYh8nI5FnuDnccmFnmDH9pnmHLdeF04DdoJ1NtO1Mu9oSNICle3xVvIKJcYJlU4z6UnfLHr
	ZnObAbEZKp9jtaOburMYiUdGKFnY5n7sf+y+5+/xs
X-Gm-Gg: ASbGncuGU4I9W0mgn3Xbadq69Ne7zGRi+icGzxocMEb5miBMWiPR2rGWauegcB8PWLT
	vuZSr45s75kJPYdxQqCmEPCk68iiFMwsBjwx7Da75BIEjTscKkql3wmpI4j81etdIGKfWmD4BCe
	u2FK7flYYSMdR/2QFm1HdeTMDNAr5YTIYcL/ruY9BmTwaHX7us/buIU8W6gUGSYbEiI93AfLuqK
	YEYj7oueBqwUoDryz+069o/ry6tPLQF+A==
X-Google-Smtp-Source: AGHT+IHELKeGUvq/utz7XfCwr+PXpx5iON13lzJnBgL8sRMjoRNU0XoQgObKyxgle1MtoSmvweLnwwnvK8tEhbt34yQ=
X-Received: by 2002:a05:600c:858d:b0:456:22f8:3aa1 with SMTP id
 5b1f17b1804b1-4563a4fdbd5mr37375195e9.2.1752862770445; Fri, 18 Jul 2025
 11:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gwendal Grignou <gwendal@google.com>
Date: Fri, 18 Jul 2025 11:19:18 -0700
X-Gm-Features: Ac12FXwlW-eLtlDqPyhmYwPVR0xXpbglNsPKS-POR8Kg98oQdUjrjaip8zrN90E
Message-ID: <CAMHSBOXK6NScsoq6aP3-K0UGsHjDofQj6xJ=MiU4O7CeU6kHTg@mail.gmail.com>
Subject: RE: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
To: ricky_wu@realtek.com
Cc: Arnd Bergmann <arnd@arndb.de>, gfl3162@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gwendal Grignou <gwendal@google.com>, 
	kai.heng.feng@canonical.com, Linux Kernel <linux-kernel@vger.kernel.org>, 
	mingo@kernel.org, stable@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

> > > -                       if (val & (SD_CD | MS_CD))
> > > +                       if (val & (SD_CD | MS_CD)) {
> > > +                               device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
> > Why not calling rtsx_usb_resume() here?

> Because in this time rtsx_usb is not in runtime_suspend, only need to make sure child is not in suspend
> Actually when the program came here this suspend will be rejected because return -EAGAIN

> > >                                 return -EAGAIN;
> > > +                       }

I meant:

if (val & (SD_CD | MS_CD)) {
  rtsx_usb_resume(intf)
  return -EAGAIN;
}

It looks cleaner, as it indicates the the supsend is rejected and
needs to be undone. The code is in the end indentical to the patch you
are proposing. This is just for look anyway, the patch as-is is
acceptable.

