Return-Path: <linux-kernel+bounces-894358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D280CC49D49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C27154E6E21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04914CA6F;
	Tue, 11 Nov 2025 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLz2AIKL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74117E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819800; cv=none; b=YKQ9f2BsS3NMIhu7Raw5Q61bfVS/HdI9YT5MCoLFwaA/FXMR/LVCL+/ri6rh88kdklG6ZlMyan+lqBum4QqeE41mYnF3RFbMDtbgd2+kKpQ+O33YC1MaINWKNXa3qsQgIhpDDnaD5v+GjGKUxIgmVPymi94GW19EpezR6hjnB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819800; c=relaxed/simple;
	bh=gZ5/m077XwBZLhAmwLVAiJZP3Ep+Vx20A7NkuQEHPPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs/Ctq1wyLz8c7LeS4wUiJ8gvTcHuax8GtC9vD3i7qUz7k7kN82EdkdCdWBtmgiv37uRTCKwt6AhYq+lcWLIBVVLRp9HVGj2jYYLDVZxkZIhKuzgqd2gZEy6MsSUMZjvRIcgsR5tywKVLnnJgbdnUlqZe5224kAT4ULRglq8jNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLz2AIKL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5930f751531so3359270e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762819797; x=1763424597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFEHCNfHv1D8JoCl4Nsmjn6JwQRfPNbQJk+sIWcQCWU=;
        b=gLz2AIKL6xMj9C1Sa7+YRItNJbgrocb9By4S/yhj3r8aSr39URnhLjz/08r0cdz41D
         LQ62useSgBJ2OYLXR42XyTKLVcjKWQf1XMfMQGwUDAQl/PsFEF34+Se3aFt10vWE+bBl
         tjoNxZp9EwzAVeTEmnr8sa950CnhThpknF5i0BB8oTyNOg95POPpqG4jRnCw9qGkjnLj
         MlUMRqHJQGxqUpPJ97iL3E7MQChRtbe1cIRyncJog+MKxle0oBDiWVfT6Nfq0AHjOsmZ
         VsQz0J38lV1uYVQawzJtyd6V0SMKovkJcM+IDt/BJJrlrtN81ogFiKBNiucB/lcvtQW0
         FSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819797; x=1763424597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFEHCNfHv1D8JoCl4Nsmjn6JwQRfPNbQJk+sIWcQCWU=;
        b=g/KhEuzEXD4DAbl7xYiF7DozKfL+aOryQ38OGjGKvh/7sMqB6PqozGfOZSaWmvNrbT
         7Y5+6NKwqKk5JlYtE4sPsEo5wws16eAiqTli1bQNeJ4ZRPvW6wbuYWCHzYfexTxMnllF
         sYc6m8BmfrF4fi0EcMZYCORqWXXw4iQYylWXH8nRbpjF9OjV4T9/zibInRq4I1OkKQxN
         X8DigitY9YOdiub+ArI2VVLIQMh17g9PcpC8BjtuU/WqGHMtkT7QTI0o6GfR2abD+3Jv
         Y9Cs/H0r0UqvFgiZt929+bjHQE/p+FTpt23frmHK5NKP0O1Icurb8cTFnAUi64D2hwb0
         AKQA==
X-Forwarded-Encrypted: i=1; AJvYcCVe8M/Nq8r9XfQ//zbufTao2zCSntKeyONha8tWc2NJAap1tXrq+98JS3N3yJXfkUnCzP7npfx0HBnyUuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsY6qw9A2h+gjIpC+zc4vEDdMJRtn3FEqvLXbU9cL+grFlK1zl
	lwXPpglTOXYVnDMrzAPPKuWIBS6FPbVZjUxrQOuTw4wTdudGa3IPT+G05Uird6HCjcnDyDX9oR1
	jFLn9UiYCYZfZUrrE9eP18ZurYRpSAJHipzhHU9Ns
X-Gm-Gg: ASbGncsia9Y+fxYAJZHVvsb9K5lzcOiS8koBufJfSimuz4JnYIYrsTG8FZ4eEia+6/e
	/sxVA0KUvQqxw58DX7Is7m9e/vN7lOiegfbIcaLaJerlngv762tjBRQX5qVDWiQJJ2nF1N1qhJE
	uWjhyjLifybgHeZA9cMy9aj37T54xgmHRGhQZFyUQAlfG7PY7COC3CNcTGI24wDCtbvjE8cat4E
	q9xIB+O27/G0TgMNSQfpYPxyjER8agxOfUf787LNZ66E0oi4QYoD/kDL7QxpYsSIceOg0I=
X-Google-Smtp-Source: AGHT+IHo2L5BMywZB4ygtkbG7ou934mmvSM1iJnq4YXV+tyl1PbwOxo9qYD3jNo2QlU6HODLtb4dq1vYUatSp3CdWDk=
X-Received: by 2002:a05:6512:3d87:b0:594:3020:f88a with SMTP id
 2adb3069b0e04-5945f146154mr2982019e87.3.1762819796505; Mon, 10 Nov 2025
 16:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com> <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 10 Nov 2025 16:09:28 -0800
X-Gm-Features: AWmQ_bl8_Cdy60TogV-QJ49WsEn_RX2LsLOaqoNdfUT7B2UZ4an-cWntLVlYT40
Message-ID: <CALzav=f5PSLJifD6_0iqLW+Uh+zQ9f_N4zVtq4ikon1gg_h3TA@mail.gmail.com>
Subject: Re: [PATCH 2/4] vfio: selftests: fix map limit tests to use last
 available iova
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
> +       if (region->iova !=3D (~(iova_t)0 & ~(region->size - 1)))
> +               SKIP(return, "IOMMU address space insufficient for overfl=
ow test");
> +

If, instead, this was:

  region->iova =3D ~(iova_t)0 & ~(region->size - 1);

then I think this test could be run on all platforms. The kernel
checks for overflow before it checks for valid iova ranges.

