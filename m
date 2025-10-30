Return-Path: <linux-kernel+bounces-878515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C9C20DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0387E3A9456
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108D932BF43;
	Thu, 30 Oct 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlXGt+lr"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C2329C60
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837281; cv=none; b=AgP8GaK6o8B5fV7XS0bxyvjMUCYv+t43qsVMQGzl4FCUQNFCtnu0d+OGXtzMupkZBvF5qZwXcSlvwyXIwv1Oyfo/E9XPlS6eZNrVKbyvZh5X2xMVDJwPEadt6T6PNMLN+YsUUR22zU9T7EtbkOYoJp7iDBbUpQbtPUj7Te30clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837281; c=relaxed/simple;
	bh=q5u917AXBpGP3AAoXyV5DkPdPFiNYJqhzNP2VhsyHCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sCarvn/jcZVmcX29Q7d/dPA8wtiRgs8amOV1RKiP4akSYpBzl6weN1KG0GVViQ+KXeznceEQgVHmM+WIGDZu3DVyzyKjUk2j95TIilFl2eTDGimXu9JF5yhvFS2noodZWYG1YfrhIk0p+gXNxtJn+/I+VkVEtzGJPqojftzY0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlXGt+lr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a43210187cso1094316b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761837279; x=1762442079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2V757dWx8NjtY+beH0DLhW2WldW9jfdjKFDrbQ4CM+Y=;
        b=vlXGt+lrj4L74AIF76EB38mN/d7UV9fHzsaoJb3epZuBTrICef1BTPEBiFKZvZWAMq
         dXi5vxRlkwjnONl5uB2smo40pCv93GkywDX9waNHhYfgYEEYvpCLy74zAIX5BC3nQoR5
         AnWlNTK+Uv8L4yiEGHmVXt+xxLHASjbVJfX0U6C6tuBqe4b2FPPM5MpwQtzQsq4Vo0ys
         lHZoEeQyCXf2Rtm7P0zxTfx9ET/oC53v94eYNtnwe4as79CtHko80H1wZ0U7UlRubpu8
         sMZh3AFcPwL5xtnZvdwJR0hZuHMqm5sfwfz/JD2nepZDPGtppYg8Bvz/GopUDvP/RFC9
         Djhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837279; x=1762442079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2V757dWx8NjtY+beH0DLhW2WldW9jfdjKFDrbQ4CM+Y=;
        b=KRvW3rxMR9W5gUJPtB6yhZuWJoiqhfbbV7gwKsumj3GUaf+ODd+7qCO1ARGGBmtmfe
         nesPrcPuO3WFQTjWQZiEO1odj4cYIT+S1MXms0Zuk52oUm5hiMBORSMZtQ1rAFZAa4w6
         LXZAPiaQwhFRNhhdzgtKPpWMyth1iuVYOuPMf4nUc8e3IRtOdcoqFMS4iuHiQ+/lRx7R
         m+h2QD2NxA5iP/t4kdXLk4xOV1ZoOKUtnBmLrPqFwJCqyggfbRuXv7TloDHgtZrFJgu9
         IrKd/2XPr1mvlRpkYa+hBAQMK+DwnLDy0c4hpzH2qavMphWev7W2dKWUWKJ6RxDrkKEy
         vWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNaNxl3yucM/eDQw5Ga8pex04HpMlBy3lDiCTjG0+R8PS21tILsBUB56aBrPYjYCRS+97mVj11O6KcXrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz84zIcMJ1itXQr09bsRVKYXflXHVXho0RR8kzNKg07wboriZm
	O69DJaqv+xv/3kHAWvTPaBfjDv17SfWPHkxi/SJDdERcDhpM9lvUJJDYmG3zbZ8tciQbYe+9JZJ
	75Td7Aw==
X-Google-Smtp-Source: AGHT+IF1+9e5Mg+OvNtBdB9L14Y1wMn9IaevQsFm53EFjwgHx+yS9BKMJ5FD/09bXoGZHhVA3Nnxwe8E7ug=
X-Received: from pjvl22.prod.google.com ([2002:a17:90a:dd96:b0:340:6aca:917f])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2450:b0:342:968e:87a5
 with SMTP id adf61e73a8af0-346531476cemr9502887637.7.1761837279309; Thu, 30
 Oct 2025 08:14:39 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:14:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMqAA2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3cTSknzd5JzUxLzSAt1UAyMTgzSjFPM0o0QloJaCotS0zAqwcdG xtbUAkd6O+F4AAAA=
X-Change-Id: 20251029-auto-cleanup-e0240f2d7f2a
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761837277; l=1372;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=q5u917AXBpGP3AAoXyV5DkPdPFiNYJqhzNP2VhsyHCA=; b=Q32HW3SElUSmJ2I/NBWAqR3UAwO92MgUMrmQdUuthU3UqV1Qa+mM2UIVqKCXriWsf9STjE08N
 95JGMMEGJ7WAyYbRS13MSb8PKK4MECm+UWGK/g5mplnS1wDPzKXpm4X
X-Mailer: b4 0.14.2
Message-ID: <20251030-auto-cleanup-v1-0-db30584fadfd@google.com>
Subject: [PATCH 0/2] usb: gadget: Auto-cleanup usb_request in f_loopback, f_tcm
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

This series refactors f_loopback and f_tcm function drivers to use 
automatic, scope-based cleanup mechansim for usb_request objects.

Specific considerations in each driver:

  - In f_loopback.c, the shared buffer between in_req and out_req is
    handled by nullifying in_req->buf before returning on usb_ep_queue
    failure. This ensures the buffer is only freed once by the out_req
    cleanup.

  - In f_tcm.c, explicit nullification of request pointers in the f_uas
    structure on error is no longer necessary. The pointers are now only
    updated after all allocations within the respective functions 
    (bot_prepare_reqs, uasp_alloc_stream_res, uasp_alloc_cmd) succeed.
    Existing cleanup functions handle any stale pointers if an error
    occurs before the structure is updated.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
Kuen-Han Tsai (2):
      usb: gadget: f_tcm: Use auto-cleanup for usb_request
      usb: gadget: f_loopback: Use auto-cleanup for usb_request

 drivers/usb/gadget/function/f_loopback.c |  30 +++----
 drivers/usb/gadget/function/f_tcm.c      | 141 +++++++++++++++----------------
 2 files changed, 80 insertions(+), 91 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251029-auto-cleanup-e0240f2d7f2a

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


