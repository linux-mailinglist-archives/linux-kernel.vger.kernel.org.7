Return-Path: <linux-kernel+bounces-892629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186EAC457BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E8D3B42DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23AF1DDC28;
	Mon, 10 Nov 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaaQKhIV"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C58F7D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765259; cv=none; b=P3U6I35OISJqSVoSy/izEd+rpkWvLB+LitXs2nJY4JHinrCkEloWfePRUfweUfqMRn8dZzyF1FGneP3t5HPvLFhBinHL7JRjn5wPeoKetfeNjUgNgx27VyKX5nKnrNTcTMsPk/yZ8T+xhPBD0gaVFTMji3owgrR/L6ky5oFungI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765259; c=relaxed/simple;
	bh=ACwY9CMD0dT9ZZK5n90967ZLaSorGUixTT8YoSe2U1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ceOqRrAHJc/DwJpyVHkwYtI60r7S/MMwCPiGEdQ7AI+XdgExmZH3DVLoHSBQIzDehwKLgP3jaHF/Td6FU/U3FqEJcaLfv9IpXGMFUWyuAPYOgccB0ZWn3a8ItFQgpB27v3uBC+blrCunhYGgNg3U8P4b/y+EsunFfwWrqZn6Xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaaQKhIV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so23300165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762765256; x=1763370056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGdTXOe1AFQpHL18BKwLx+BmvBS2qKOFFibw/YjKU5M=;
        b=RaaQKhIVFqfiVTlUXQ2pNLWFYEh4gmkSd5EvfJ7LxccXiL5OrCvfkiOAEVDReQqhFG
         l+VFRqZisWXU23n2oV5nFUmL2DwyEoLoKkdWZJ9RVE74gx2XYL8/+XqwvT0h2FWtAJI1
         4tXSvJGPbQ7qOuW3SYnyNuyUmMQRmp6mTqyTl718fZXhO/GGTQSDUrbDtFkJWEXwaWZq
         /u3+DHMD62Yz/98YLv19HS0Y5AlsIlL47mmVaiG17mmb/YFRtRtyGhlGZ29XVxMbxrJ0
         AHlYtzTmQwe/w292WW3ZP4/TGe+vTx/pLBYR1hMPARqI3Y8KaDy5vWTCAMoHOqlskfDe
         F+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765256; x=1763370056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGdTXOe1AFQpHL18BKwLx+BmvBS2qKOFFibw/YjKU5M=;
        b=V03N9LanbLcnmnqUV6QtdTaAS84N1zBQzYWNiL2micSpYBLa5naUx6ZEnar9kra76/
         zMyXLcBlzzVPWi6K0vnPhje84VdoZKT9XvFC58rvC0Fc7qYBNSZrDp7Wi0GjSh7PS6qM
         ULq+YqU0gg+2gpSmOZxRz/3e/Ej2bUc3Wtu8Ds+7cXIbFUdkAWQNZzAZ8WGrB94UsIaw
         /vnx3vDcvzLeiye6MGeNWLuHbfuIJEclUhMHPGrcYCxPbmUSwN79FQcr41h8h0OptWHs
         AuJFKESvSh/zNtQZzQmBu9bTl03+bdXnddEr5UnOgYrwKWo9yNJAYuZdAha2FcIWWWI6
         drhw==
X-Forwarded-Encrypted: i=1; AJvYcCU7TZPxWASYkjDyfDW+APEc+nFPdEDiRHh4K8dvk4IyhR/6vc3D28ZWqoYHAIkbqxEAXhHBm0kJ5UPhe1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyErRX0ZjHTaokL+y4i62Mp3Lyy7+U/zRx8eC0aqwdIvLYE2Ad8
	40lIcKpUXOltdnPxB0bIt/5ZTTEbxURaT/zyLqPPjmqQrKzI1M+onxZbt5eRewdFes6EqChrydS
	YxRqMe6U5k8hlnuFhCQ==
X-Google-Smtp-Source: AGHT+IEqIqpLDNcazaulUGcLg0FMYGmXoUPkAiHsq8ZC6Ef8aDLodMIuJxGVZi4sKLPnHOLpPuyXQbsRPditqsE=
X-Received: from wmbdx24.prod.google.com ([2002:a05:600c:63d8:b0:475:d804:bfd2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4514:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-4777322f11cmr66874455e9.11.1762765256025;
 Mon, 10 Nov 2025 01:00:56 -0800 (PST)
Date: Mon, 10 Nov 2025 09:00:54 +0000
In-Reply-To: <20251107224824.644832-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107224824.644832-1-cmllamas@google.com>
Message-ID: <aRGpxiqweu2zWB3E@google.com>
Subject: Re: [PATCH] MAINTAINERS: add Alice as a Binder maintainer
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Nov 07, 2025 at 10:48:22PM +0000, Carlos Llamas wrote:
> Alice has been reviewing binder patches for years now and has a strong
> understanding of the driver, so this patch is well overdue. While here
> also clean up the list from folks who haven't been active for a while.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Alice Ryhl <aliceryhl@google.com>

