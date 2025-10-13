Return-Path: <linux-kernel+bounces-851276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A01BD600E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B71407784
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB62DAFC0;
	Mon, 13 Oct 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gw1RMSQ2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014C2C3265
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384982; cv=none; b=qkKZkrt6Z1MVQQzE4ekT6zAGVxuYtf5Sr8gfwa2YhJVsoKLaJNBSiS9Uypz36dlmLRMLngFq5NftdQLYgYW3987mGwzewKu2HSe3SD65FBbVb7KeJnO5bXFCE76UZVI3QeX3GVV/X4washubR0qI98Oj94GI6cCKD5p6qDvbG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384982; c=relaxed/simple;
	bh=/DrKiXuWmXA5zXJIwBMSXqDq5Rn8SXQvuQWnNtsh0VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8K/B7eO4Mh4bgRFYtryTwA1utZE+g26pEWextowM9jsPTBOWVEOoYrYygCsLAzgKzXvJMyMEXz+U+BYxES3N/HiUizrxGXAhuXv87/KitmeDFMLXMzUgEKXUZCMi8u0OUf4CRGKUuYYdRFCdSgQvr/i0xQY2j7LCrXhl7mSlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gw1RMSQ2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so29527165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760384979; x=1760989779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DrKiXuWmXA5zXJIwBMSXqDq5Rn8SXQvuQWnNtsh0VU=;
        b=Gw1RMSQ2YLBJ5WEEzmrGrFHdpMMqWCKNVzgLrWEuH2r7COHcEhBiFKpgG7MhXsZh1x
         OMRznKqtNJig0TvsaFUEDxWX9PPPyF6XHEXkydWLVi4k4MZ+cFe+f7HvfvQarBLvr/0H
         JkAIf/NCTChQ3lGqbfA/Q1tLUsHKlOjzeK+3FIC97rcqRjLLOBfkMnwyrnkkn94ObFEY
         T2kCt0DHF9cXRe109Ryrlz3zH+5Zg8sh2C0CGM7OGkcH0Iv5c7/I0ZRYAXrJzGa4Xf5u
         E/wiwY4gNtDRs4hzlv0KJiV0prQKsLA7TkxVsMrGFSU1FqGfD4iem72/fbDgWtL5kbJ+
         xIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760384979; x=1760989779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DrKiXuWmXA5zXJIwBMSXqDq5Rn8SXQvuQWnNtsh0VU=;
        b=DbtWcy9RCHD3fhsSyHTScESfAYOhWK/fKWyT7Oskv7y2JG5Kl9BYbvcaJlOpu3BdOW
         w/Eo2yICqWEHSz+ltWfsesrukQzJ8/PfNiC/SGz1K9AeJHfutDmBrn25TiwGANJL/Eoh
         pzdhW/pF0lxpwZRRTulaAWHcCzR0m8JCrtb6BYg6cBXCnfpJAPXokHytvo0AHzBR/FJe
         Q6zn3y4wzYGVI+RtSJD0OPrYT7D6lSjPhmb+w/NAgPDxd6XiWZWZFwdpqNUvgtXfDWrX
         vrwPqqJGZYSnj7bkmLLs9lzFZEGbUyEVfO0fAhXlNHKD2ySXG17+BDdsQFhtZKg3VWHi
         TbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSD6dcE9gLODwnuiF3j82S1XCkPk5ZL/95etM7baRJ6QNMYtuM2duW+QsYXcEDhR1T4OX0kE6mAljXLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEilF6Cf2ucD7fR6fJ8w3kthF2od3oxu2pYYYPmJ66wMWQJ5wV
	7DMEuOIqXRclW9zuiexQkKKTyG0pIm4hnJDen4s0+vL3Mi2KDVYGAthCrRFROYGg4zDzT5PA4sS
	/Kd8iJNmFxhOaU64pkHCzXWL6+xdX5yIEVJI3dRa6
X-Gm-Gg: ASbGncvnZU8ccdIAf59bXwB41x4Lt5GevPM28/RvK6jdx/QfGxArt79wW0HVFeupx1X
	zZK/88zgkkOLqcBltmhlxhNAXLUr8gf33jfJl1kYuFkfgySovRG9ZML3vdX1nhuhvwsKBKJXmeI
	jpFrNc6F1/GK9dy1O7rv6CQ8jV4tGdkLhXk8O/syPx/SMYXKOkeMeaZDtctM+mYyOJBGZvzwPAW
	3p2J7VcRUd5iGrI9WEZ1ihcEbhRfwzWFDXSfd+qiPKO152bRz0zYGAIx3Yxwe50bdPKXX4C2g==
X-Google-Smtp-Source: AGHT+IHY0QThJviNDN13Na0YoMT4nnE0a7l4g/aXq2yJNMMpvrw4aO2zCu7aZscq5GGO+Y0OCsnqucCGtPNGmRlRxaA=
X-Received: by 2002:a05:600c:4e01:b0:46e:37fe:f0e6 with SMTP id
 5b1f17b1804b1-46fa9b090d0mr180438765e9.30.1760384979034; Mon, 13 Oct 2025
 12:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009010312.2203812-1-jthies@google.com> <20251009010312.2203812-3-jthies@google.com>
 <alnlmxbcv3ivhh7iolfqsurhknnm2o6i6waxq7kuhmzcbeljr5@a4wy3prshu3c>
 <CAMFSARdzoZrv4oXxVAYRcZJgxdLcrTMVAVGa=D8H=9c1vZ0zKQ@mail.gmail.com> <fciyxaedvyqeppldl26rsy7hogoi2zks6tq6m2yu5xerfjxo3g@u6vzsiicv5ke>
In-Reply-To: <fciyxaedvyqeppldl26rsy7hogoi2zks6tq6m2yu5xerfjxo3g@u6vzsiicv5ke>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 12:49:25 -0700
X-Gm-Features: AS18NWBSBKFbpC2dPCDDX4XxbL8PoeUJPBg6KiZ18nToguJJIvN2knvCEUtPr-U
Message-ID: <CAMFSARc7ySH4VhGbwd+CXXC9845NUkf-RE4gKeTW8D_9zNY--g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and
 ACPI definitions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org, 
	robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com, 
	ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> IIRC, MFD devices support binding subdevices to the OF nodes. Do you
> plan to use it? Could you possibly point out the example DTs?

I'm not planning to add this, we want to move away from using the
cros_ec_dev mfd to load cros_ec_ucsi. On upcoming devices using
cros_ec_ucsi will just be loaded based on ACPI/DT. Regarding example
DTs, I'll point this out in the comment.

