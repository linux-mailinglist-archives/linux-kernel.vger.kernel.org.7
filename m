Return-Path: <linux-kernel+bounces-845960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9FBC6944
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF25740472B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730C28E59E;
	Wed,  8 Oct 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxeNVMkR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882D28D8F1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955132; cv=none; b=kBvxSv+9KWgfvbX1opxe8XPHmkhuizmRxKcqMqPndztr3wI+TvK2ICQzYYn7/Y2wbSrrdVCaBFCz36ecTr4Je+8JRJOTZ3vyJrAm1ayw0FRXHe85WkpcWdFQvDzo1F3jDWfP6Yrk7xOBtXEePgvhT+JGY/AGqxM0ecI7g0IVCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955132; c=relaxed/simple;
	bh=pkF8t1F/yS30PeNW+BPwG2wyZzv9rA3CJHnyM+CBV8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHXbnIaPXw3TyMNe0ZMZAv6p0BzgqIT/4wpl9JL0XOL/S/atZpOzpCsin6BGL5mlslcWqXJvFr6lMipD8QTGTSonhhkjrH9V8VZqk5UUuO7Xu8AElB5lM47ze0Uw84B6/Az8uzPgSZv0865yA5K+hei8o57BfyPIRfsxYZYrjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxeNVMkR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso761755f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759955129; x=1760559929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkF8t1F/yS30PeNW+BPwG2wyZzv9rA3CJHnyM+CBV8o=;
        b=sxeNVMkRmvVcIW6G1joRFUabekdHRsrGDJF8sFzTJgn2g+47ANZrKMUjNMjyBlA31y
         8zCPbJcYNoxEYfc4tRYmModsMlOakxwYYvzHcMMPljd2/gsD4I8DdPIAU17Yay6Mq3aZ
         GIxijUzHxSvCgiCpMo06gIe33O6O3pW3eG+hgqwmKcCPSJm88stGNILXlf0i9LaY30U6
         eWeaI5xwWOqgF/AuQWGk01vMyMc8lzwqqNiZgp8iFU519CeRM/Ag69R6d3DgK9wMuDuY
         ipK7s2kXVY8FOf5sEknF57bSytsPwkkJCpnc2VPITsCBQ53j36BwzPIStFvJOX6Yiw+O
         +WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759955129; x=1760559929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkF8t1F/yS30PeNW+BPwG2wyZzv9rA3CJHnyM+CBV8o=;
        b=YIg4hcJojfOA/qrxzS/ygq2aQpIvS3HklV5FNw+0/C4S/1L4jhuwNNQ1xmJBZODYSo
         TXnmF3MTT1hwueAZT5wgThJoyLbYh1oUSMqQXCje0uTPWWjgPfkr6DsZnvl2GUDmO+3C
         WzI/qcJBQ71jvMkOtLQxm/ERW8Y3T7alruGUSlOYkrzWWBxM7vTAGJZ904YSWG8GNfUb
         UdfYIAxABmfEizw2ldii2gTXKj4/Ec6Ga0TVvKKh4Fu9aFLVc1LuT7Berjh3nu3Kfrcl
         Jn+LDlTa74KkVRN7oiKLjbZWfQEEppl2BYaKwi/eKzDOQp57nrVFNuHyNvNz85j21sYY
         fCRg==
X-Forwarded-Encrypted: i=1; AJvYcCXC5MxXMExqXWyN6OHACYbJScWtMnt1AqK5bu6ty3okZ7IRRNLoviLaOCooJ6/GrmKiGeP+qmnIZ5zzMU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/k8vLtTt8sWRDc4CLtt+HlajvkPCo2ud8YcieX3oQms7VgMv
	BGNK2QCQgJ9Ib5G5BAjZFkr15tUqw8Mv2cOcmhlMafarexVu4R4c6uiRutUYcVqNrXrbrKGTZCW
	8glK2o1HbUXH74PeczJGMVxZ0Cgfv+T7RcFuALZ4b
X-Gm-Gg: ASbGncuj3dTRRTcXcuv0shWyHYlQJhYq69YV4kh3JIyRj9O8KyM54z1z5Ph0gvnwDSK
	t959ZRvFIm93eUmylPkXVl+qFBHgAknMM8lo76oAOXN1maD85AhhhJPxI3acujUl/3Fy8GtRM/f
	U9kjwrm4MJg/m0pcNudkuZRZe6cve+G40MyIiOQl9meINeZfhV+ptqmPj0i0MgVI/YjZl4oC+lz
	n0cg/mx+7aCALIZIeVPbwkrNekl2huZK/kbFVDoL9OsSqCz1KVDU8GeWVQf9wvFmaVeZVWjvXaH
	G/Q=
X-Google-Smtp-Source: AGHT+IE7vszNjL34ga6ZlF87FGJyCFvkLaT4QME4cTsoSkHUnw1osUy/bHfoR1cCedCCUNKAN+lPRA/JTrLq5/lblcU=
X-Received: by 2002:a05:6000:24c9:b0:3ec:42f9:953e with SMTP id
 ffacd0b85a97d-425829b0556mr6352133f8f.7.1759955128611; Wed, 08 Oct 2025
 13:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001193346.1724998-1-jthies@google.com> <20251001193346.1724998-2-jthies@google.com>
 <20251008160354.GA3764744-robh@kernel.org>
In-Reply-To: <20251008160354.GA3764744-robh@kernel.org>
From: Jameson Thies <jthies@google.com>
Date: Wed, 8 Oct 2025 13:25:16 -0700
X-Gm-Features: AS18NWAXqAZMg1YTF3Xq_FAQ2QhulCuEZTvP8EM0hBHj6dvno26tVBuRXa5noQ4
Message-ID: <CAMFSARfvBQrwdeeCaBbqF++HGNyAza40usFLtAoij4Y52r64aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: chrome: Add Cros EC UCSI driver
To: Rob Herring <robh@kernel.org>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org, 
	bleung@chromium.org, heikki.krogerus@linux.intel.com, ukaszb@chromium.org, 
	tzungbi@kernel.org, devicetree@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What's PDC? What's UCSI?

PDCs are "Power Delivery Controllers". It refers to an IC which
manages PD communication for a USB-C port. UCSI stands for "USB Type-C
Connector System Software Interface". It is a specification maintained
by the USB-IF which defines a standardized interface for communicating
with PDCs. I'll update the description in the v3 series to provide the
full name for both of these terms.

> This is the exact same binding as google,cros-ec-typec.yaml. Why are you
> duplicating the whole thing rather than just adding a new compatible
> string?

I separated these bindings because they are associated with separate
mutually exclusive drivers. But, I'm fine with adding this as a
compatibility string in google,cros-ec-typec.yaml and will make that
change in the v3 series.

