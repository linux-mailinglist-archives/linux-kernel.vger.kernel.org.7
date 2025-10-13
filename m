Return-Path: <linux-kernel+bounces-851194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE92BD5BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EA334F1610
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07E2D73BE;
	Mon, 13 Oct 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIkWXCbO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B152D5929
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380475; cv=none; b=kZmWBvCmOogvhqRGAD7tNIWr418GeaTeRg+gseklbZJsASkp+h13EhsbK71sR4VOzs9wjSPzd2AYUpbGE4fZyXQb4saawlNfVSQ9WWsEDjrR0KAV5OzY5L2ZmAmcqQmx8tUSru4t6OfTQbOT8VQEM6md907BgDWklHau0nPwYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380475; c=relaxed/simple;
	bh=Afq6cNan9t/2gw+te4XV8ANY20V5fsOBm2d4w/26+qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8N8X3IfIjt8QxzcYhEe0V8jyd7Wq/ThWYk4E2P5GwHEVunsjGO2m+LfKo3UprDLM6u1JDautMpjiKlzZNFy2Tli2mkgQR+OUv6zkQjzxkBFw7QU01JQDAJcGGpYtXVviOYgnskKccD23k0t7CbEKUK7Wi9ddyrpvcrjR6yThtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIkWXCbO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so24580a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760380471; x=1760985271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afq6cNan9t/2gw+te4XV8ANY20V5fsOBm2d4w/26+qg=;
        b=nIkWXCbOHSMGaBqWWJJmrgsAOXnOGgEiGblZlskaHZzFrQfFQ7My8Y2pljgDsLo61J
         K1bpH8xUPqLhwapCb7r0SuD3oQDkVReBl/FdzbtYkpcFCLjPc0PMiYHpWnplt1Ckpnj8
         b1g0OTjNB4LpNcb+NX8lRvMgWTwSHlg8XEP0LPkcnqGUG58bG9TLQec+1OuaPrxdWvzP
         rHdTyhENX4Bpr+OoUl+wKntoEUpnjwWb0lTRQZXi34JvHMB8rFITJ8SaDZclYdCtb72n
         +ot0KRy3lKiFmqGKYrUzTwDBUBg4WUs+Te/4EC5nmeEROXoNaf5cF2mJUMC1kH8+eZZU
         cQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380471; x=1760985271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afq6cNan9t/2gw+te4XV8ANY20V5fsOBm2d4w/26+qg=;
        b=CVj2qmbSNIVu345KOCz5dfBFkpcQkBqjjvhgB/LHTdaFd2I8kQZBW9UH2eS+j0WYby
         indIKaFJ8t02006hgU0ADZQTxHtcaWvnSv9kzzocvFAOG1hJc24s0KZxJFgFJxKT9OMk
         uZnNq866eXNdZGop5/+r4DZVsKfTVgrB6ai8kH9XbssORA+82upfDGTaLdkpXZO8kgnu
         pgDNfKoXk8zewuzPFzB2yf12U5z1YJms2V45liiEFCLCE0ZjRLx5zWvbm4zn7vCLgYHG
         yP53jeLmUdsFjhOm6vYLiTllb4wxT42ihvzXbNirqXUvpKMzViffwIsj39tVexbgBy+B
         7NnA==
X-Forwarded-Encrypted: i=1; AJvYcCWggWH2aVo71cBPT530ZMinhaxlRd0Y0P/9GJDByZLX5i0dRHvLo/pJfPJKtKIv6zKCi5x09GI9Ah/ZJXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxB2oXmcmKX4KLNELoMfB2SoOP6uInScenGnDjYE9BVO5TlLZg
	2WThrzYHAm4gi8FaDapmZ62EIFEZJprnh4XuDgGC9GbaV/WSqJ4zX11sx2PBuWDse/0MuG0Uqn7
	XkCxUb/nVLo+0t8Q4rpaGRiZSn4dmoh0bW6/w1Att
X-Gm-Gg: ASbGnctmP24CNKON4SikaMyfTJZBMLAQjCGyqJzfbGMrWIEUwUHxHYrR0+aPSAJIDSW
	LB3XZxvr2EMqIr/KsKAdZXtYKZzYUj+TxRTV8PkqAuuWclQvC0S9KDs4wvJWsjYZOxhIT4YysAk
	5vXIR6elMHQpRcCOaUM3mhG6VdYAQJ2/ckiuxdmB+y57tDJWZTGg/kYDoG4rKFAawp93kIlhrWr
	RawdBGCvk3Z+WoCmeP//XtpFuAzAOd/ILoo3XkD9WdXvbcQjvlMXw==
X-Google-Smtp-Source: AGHT+IFRwNFRw95/PZ4giLCn1mM7Nqj94TnRmfK/bODb4e+FbWoWD5Kzjyueo2VriuqMV3KAw8pFMMhjt3TSmvoOwWM=
X-Received: by 2002:aa7:c84e:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-639d53090admr609561a12.7.1760380471100; Mon, 13 Oct 2025
 11:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-9-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-9-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 13 Oct 2025 11:34:18 -0700
X-Gm-Features: AS18NWBIFyEjfltOcvssGoqGJAnQhP9wY-GXD3bDQRorIl3BP8PPFn-W1mHZQBM
Message-ID: <CALMp9eSwzYaRVa2eO-o5oyfK5Cj=0kscCPQhCxZGQ5WWYFgN-w@mail.gmail.com>
Subject: Re: [PATCH 08/12] KVM: selftests: Use 'leaf' instead of hugepage to
 describe EPT entries
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:05=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> The assertions use 'hugepage' to describe a terminal EPT entry, but
> 'leaf' is more accruate as a PG_LEVEL_4K EPT entry is a leaf but not a

Nit: accurate

> hugepage. The distincion will be useful in coming changes that will pass

Nit: distinction

> the value around and 'leaf' is clearer than hugepage or page_size.
>
> Leave the EPT bit named page_size to keep it conforming to the manual.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Reviewed-by: Jim Mattson <jmattson@google.com>

