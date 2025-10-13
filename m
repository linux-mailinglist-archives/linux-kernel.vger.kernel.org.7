Return-Path: <linux-kernel+bounces-851375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F0BD64F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE1713503D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F83F25A63D;
	Mon, 13 Oct 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrxsi++r"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC502EF65C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389180; cv=none; b=m/Ao70udPoTor3iXSrmwjKXBse0VaO0twfa45CE+M3wI8XHWKAZqjGvvvSL8+/jTaPRX20MOcvOM+Kd09fNaB/o+zN0CEPWyeYZEdwn2DoWswjkZqMue5XO64Z7S2E4aj2VLaXqL48c0g1oauRi5r3gjp+RsmoDgPeyBIMu37I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389180; c=relaxed/simple;
	bh=sG7NGEDvazkQFTLe25gikpPASVjElHvfGph3Osk9HmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkZLEDOwODKprhYNiOWmTNAYvrb8YOz3QgTVUowz7Sks2/rpzW5ZsTdWRCR0QkWCsPysAq/sJBymKfPH0xAS68xBCGcPij6Wsx8Tahmt2tKFL5BmpL4+bbDc66oE+gfEKb2XI74GatptobJJRL9TAkTHE6k2nvchlgY7cU3r+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrxsi++r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-58affa66f2bso4955651e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760389177; x=1760993977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sG7NGEDvazkQFTLe25gikpPASVjElHvfGph3Osk9HmY=;
        b=hrxsi++roCYJ1Z1FXYPSxaiHcPAXYRnXk/nOWoo9IOPpmxdn5WRmZ9I/H8PC6dGJGB
         QedfeXmAjaekI7vv05bA/2MkkcgndxcKGm8b2d8cZt5BuN4dlkkbz5glRGklcXZK23+4
         W7Ql5b1MZ/qyw8vBenX87bAcni/CmGPyJJ3cfvkVA7XJGCXxfL7RrtWOy3LdQER/kokA
         TeksQJQsDTUGFjaaKwZ4fn24vHR605GSy6SwXSDfDjm+h6jn5WGEEV/k8TbxBndw0yUb
         6tH4OoWoKLGuZZYJDaD1jCzODBShctU5ouG5Tp/Ut362zYJMcAVeW7sjduhcT32N1TRN
         kbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760389177; x=1760993977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG7NGEDvazkQFTLe25gikpPASVjElHvfGph3Osk9HmY=;
        b=P8KWnAcZTrgYT45PyqPY1fUoh/2JUohXxg+mj8+qtVjfWDOHgiF/8MRu/edoiSgdcr
         Hby/Wc0iJIiZO7f+JkOgZkAdEwdQGh6YaIaA1b9MjuzY0ZQ1Itg8AvptSDOOBv87olOK
         NVwc65OqgVsvT+a+P0hSVePwyMLpeLe3J95XpOUqdRDHtYpMSSGX26MdEzi9cc3xoqb6
         KklB6FVVmfiYsQNF0w68UyUfyKLQXEbaxccXyYOjqF9o0vX5fdZ+t5xKdGbabOgRBvgB
         Gl7L9HbiAfp9hyyACsQ3CSqY/htIuIQIq0wJmncbGxrrehZYPbZTglhU7rxX7dxj2RTC
         JZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUGfxeFEp6JXyoFD9A8PiQ+PZBFMTXXjImi7EI9dWi94kHBWv5qJE5c+eB6gAELotb50JWkqzxn1PhIJBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdyHuSRSWF+RM+W2Pt3ywT16GqqeMlsIg4caQqjgztoj0ASDP
	KyyDXf8329gX5nAwEgq2nIAdJwpIaWg/C4VfbgL4r60w3ZfGAt9Zmg54ObZHbDyfx7osziozRrQ
	obtKI2Rsmoq5uRAMjJ+2rDdJz+CrS0AFx/nQhRTd0Aw/X6mdDHEH+1Q==
X-Gm-Gg: ASbGnctuNhsjPvBu9S3IAl0doAhAOK1e1RXeK6+bFIVgDD3NAq4QYqUXTkwws/RKGug
	UZgU0l9KFBEB54Qn6uMCP/+yCdsuQKdXRd6vvcH5+MjM9/doXOTSRqX+fM29tkC39t7TaOet+nE
	ekOQ0vlddS5xMaarmHIzj+JInxb1CaZeRHXkfpCFBXZai+DIr/RgYUyeJsZh+JB5PJV5PuqNMvy
	XmcMm9P2Ww4zS2tZ0pp7664OZ3YWeX9fUW3qSyLUxCn89NDHxKaZ9Bs4qjJX3yV47JbgHJwyw==
X-Google-Smtp-Source: AGHT+IFj45Vf6vX1bjTBB5Y4cqsAZeNKRI/eLafCHoF+c8jjTmaW/C5E9tyETRqfbRkVl6TZ+XnX8p5L2a31W/hIa2w=
X-Received: by 2002:a05:6512:3ba0:b0:579:f0fc:46f7 with SMTP id
 2adb3069b0e04-5906de89a6bmr6324643e87.56.1760389176718; Mon, 13 Oct 2025
 13:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <2025101316-rage-vegan-c380@gregkh>
In-Reply-To: <2025101316-rage-vegan-c380@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:59:23 -0700
X-Gm-Features: AS18NWDGTZv_Oy2h6qwDHrqgajO5V3yrBh2yGLcdRP13uD3jCB5MkJukoafZek8
Message-ID: <CAMFSARdQCDcB=tAehoaNkjW+Ctp-ULiDTtyTSfMJX9whYaW7sQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, akuchynski@chromium.org, abhishekpandit@chromium.org, 
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for this feedback. The only patch here which is a clear bug
fix is 5/6. Currently the driver reports 0.1A max current when nothing
is connected on the port. I'll send that patch separately.

