Return-Path: <linux-kernel+bounces-801315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758DB443A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80881166E73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB463112BC;
	Thu,  4 Sep 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyHQXwQp"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93D2F361B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004631; cv=none; b=oD+lverJxZ+kHswF7ukCck5NGb3KgSXTP/yOwktnmBQ3XNXCOOkRf3vaEZGh8tNsSqz8tuoWLMfcHKNcdysJXvOT08C/OaMAaH0UHR6Kbk64x3FjPaQsampeohsYMGG1tG5GdU2xrAk/jTsi2/351Hc6CCrHi0a46Skw3npdyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004631; c=relaxed/simple;
	bh=7Eg2IdZbj7N045XJY1xJIaR/PZ7v9B940ADnZGlBOSw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LXnltWF/CEnEXSTj/4c7QjS7nLHZncfjQgIPzDY8kBK3+WVUfKE/NIEildrYLoI6PlTfo2QIWbn7ke4PYnayjz/fhdtP0TCASSBfhonj2qIK8PfZ2rwrGxjk9WFxwzm2/GrK3WLqXnpsbn1j3rAtS+HW9SaZTpDlnusW3GSI7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyHQXwQp; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7459de59821so1080953a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757004628; x=1757609428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Eg2IdZbj7N045XJY1xJIaR/PZ7v9B940ADnZGlBOSw=;
        b=AyHQXwQpUaxmTe3dIbv0w3bDhGNgsOH+Vyf0kOrDflO1AqP7v2Tg1JYLSEbr7rHBgd
         uzLlYjsBEueiaxogLmD9/umr3aJFLXF/XTG8Yho5eDOCMUmEws2VvCddWndPjNrAuzBL
         XVB8VjORJZnsUI6JqP5kFcPQj2jm8lXEJcAoh+EBDxkawTmSqE/oK3g9lP0Z+zYhoepO
         wl1T3dY/u3crEskvR3LjCAfmd71vbxoUSEEpOY3HTUBrpUgwjdnhipRP3DXsvP0gryIZ
         UXE4jzbMVudFT6dtpOrLVRJPb3aRPu7oUfFhFf990VdvIdZanRdCFmhAPGpvYDBUtq8F
         rlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004628; x=1757609428;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Eg2IdZbj7N045XJY1xJIaR/PZ7v9B940ADnZGlBOSw=;
        b=fA5axJFLPzxAt0TkNovqT6GUdW85FeGZGnDbvpwfTTFvwW4JUZWqUoi/yxSeX5oeZj
         sFKZgvvzkkRVAVj/plDJbRKV0nWLvWpIn3Z29SmEjQr28ibwWOrstMDCO9vzCjhxbhkW
         ax5Iqd5imCuX2Ols/UpNUiEkuoMlBS2zMj7TXiV/l4ftalUX/nFS/g0VtmJ+LchfiLuT
         w3cDmb4nJCZDiKNlwT+sfUpDvNa7NHPoI69I9e0jWdxckc40yS9+dL9QTkfrZDxogrzY
         Nx7E2cewFHvVSF7WAKr6TCvQ8J+FhTKW6isI3nEx8B9dNifh6mWlB+zcYIi45KsJw5uz
         2VpQ==
X-Gm-Message-State: AOJu0Yzl7C5bWbLkS3sULv+TI1KkFVNPbmjvABsXD8W9ztNmFhk7aP7h
	mCQgf34+tLOXZlAMiW9Lb/XQeHxjIoobNLkUMWtLvdjNuV7YMfsFS4JQza9WzVCt+zR+OBOeUaJ
	erZod/UNFRP7w/hLKdfGdKoRtWeG9qBa0TjmcMQk=
X-Gm-Gg: ASbGnctV1VpXoNR/qRrPKyq29nm+/0X9C/E4frpfmxH1z85/w8+KjA9N07Q4c16giSX
	FNiRm8bo9uih2FhKz0SIMvQeasnORASKZnXyrTeE8tmfCVefMKebKLmMqi1ezlxTSXHwWUK+9bS
	3MEZBTL59Z2TfwhVsgRa2KpV4+aXWL94DceneRXgnBSmBx1vx+ujW9Cd3SHKufTccqG1I/hLGfn
	EntgudjFXRm8wlTp3Q=
X-Google-Smtp-Source: AGHT+IFm4qp9Bw0dBE1PdZXnAhD/rS7PhWnQebtZtFl47df+sHLE1nZP8uiU4gSX4cQwg5z39eobd+EZAoiNuLlIOUg=
X-Received: by 2002:a05:6830:67fb:b0:745:9d11:cc87 with SMTP id
 46e09a7af769-7459d11d264mr3305859a34.35.1757004628075; Thu, 04 Sep 2025
 09:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lucas Moreno <lucasgabmoreno@gmail.com>
Date: Thu, 4 Sep 2025 13:50:16 -0300
X-Gm-Features: Ac12FXxoyV6jAGvvGo_0Rri1QnhUwVr5tZsrHNruUMHNsQbzrzsQpucFQ7nqKH0
Message-ID: <CAND3jMbggtne5+SL7h8Ojkv2yV1oqrBCTB2X55WB+_dkUJu5gg@mail.gmail.com>
Subject: [BUG] Lenovo D330-10IGL: Blank screen issues with DSI display on
 Gemini Lake
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm writing to report a recurring issue with the DSI display on my
Lenovo D330-10IGL. The screen randomly goes blank. I've observed this
problem across multiple Linux operating systems and kernel versions,
which suggests it's a driver-level issue.

- Device: Lenovo D330-10IGL
- Processor: Intel Celeron N4000 (Gemini Lake)
- Display Type: DSI
- Affected Operating Systems: GNU Linux, Android x64 and ChromeOS

The blank screen issue manifests in several scenarios:
- Random Blank Screen on Boot: The display occasionally remains blank
upon boot, regardless of whether I'm using an X11 or Wayland session.
- Failure to Resume from Suspend: The screen does not recover after
the system is suspended. This occurs consistently on both X11 and
Wayland.
- Random Blank Screen on Screen Rotation (X11 only): When using X11,
the screen randomly goes blank when the device is rotated.-

I've found that the display works reliably with X11 on kernels up to
5.4. However, with any newer kernel, the display only functions within
a Wayland session .
I have checked dmesg after a failure, and unfortunately, it doesn't
show any explicit errors or kernel panics.
Please let me know if further details, logs, or testing are required
to assist in diagnosing these issues.

Best regards,
Lucas Moreno

