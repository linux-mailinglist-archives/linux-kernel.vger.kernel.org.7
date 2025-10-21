Return-Path: <linux-kernel+bounces-863364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA3CBF7AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8AF189AD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66C34CFC7;
	Tue, 21 Oct 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMWyxq3y"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6534CFCB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064351; cv=none; b=L9wjndz5NV0KwG+hPNWUhEPQJ14anDu4EoOTeDVJ+IbXhWfCdYYMi9bI3EJpa4D9olZShrBlwgUWCcEPdvq6u/YqXBIPNk2cmXB+UIsHs/KAk1Vn8z2ipgJztCMCLgUIXHMJOkEySsZWXjcJ2Rkubb4KdopxmPScyOtY/WIk/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064351; c=relaxed/simple;
	bh=/gc/MgvEN/dxX8eBe0+zIEkSKheyGIA6RT9tRwUKaiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRjwBf1rTj+E1FHwGzmGe2xh1j4Ct/wX7sTQ2OEk7vXG0JX0BUsYJupvvZ0yLX+uLwBiooxYFrW2XSpIIqiI/Xu7hD146Zwd2/zPqgjTNXSImuWy9elafXz0ChIdhvJjrTZfnMCYSaUE4yNWpH7tf1KsP9SjJZFr0aOhjmGd6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMWyxq3y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57b35e176dbso7145677e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761064347; x=1761669147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gc/MgvEN/dxX8eBe0+zIEkSKheyGIA6RT9tRwUKaiM=;
        b=XMWyxq3y7NJjv0WGyeZHJ/cU/+ShKHWqgWKTmiUWQSe9bRpUVUEVrtL5slMgnuHCrM
         3HfCDyUGIJRKYsYU7UGtI4n46JRkYKpcDLZMy4CDGNvgtB01vnTIdM/GPBaoRTWiFVGJ
         I7jz0bSpZErsK1hwe2zTSVbFoACD63DcvXacowItnMAAtvSoZ/VzViNDDCrRgEr/J+7K
         Z0pWwUGcxuzb8PmXno0Ieew+rXvZnRT+PNuEQMvf4eEzrsccs3Lffu02rPCIlfUi/j5f
         zWJWGWdbgPrJk5b/FuEl2fv1GVz0XojyBN0qgbg92j7Tagl6J+go2rkgz5PXkQ6U4SUK
         Mnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064347; x=1761669147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gc/MgvEN/dxX8eBe0+zIEkSKheyGIA6RT9tRwUKaiM=;
        b=f9F0G0us7VGTMWrIkh+rHkiQRrS46JMY5aSJwUlO7RS6HkT9V2mZvruugpKaeP6237
         YAkz3Z8MaXE+Lm1M+jq4MqzdmFyDEvmpYG7z9zhaKWRV28aEr20fjN1zZZbLxpRVygoE
         BVHzgnXbIEV3YVcG4gBazyREvLPf3FPkNZa+NdvQ0u16M29UhkhvwAQU4/FCY2vrx0SE
         k8563TvL01IhCLmqJ9JJPHjeHrk8QvtonfIB3iJFaK9qlxeDDvVllYNYf9o344E2BWaf
         +lcn0LJE8cOC89V3M8axg1xM0+SdeYbHOtal4tdULhgn23tYQunC0Z3gwE6IzlLbBD6v
         wKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWidn/hZAyKFDV3q7IFgD66NpIq0cuUys3FG55ifsCdsjdaNCFuF33cm07mMKQjTVxpufDoEjjHrg6yJNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4/sxfw3R4/+7GaZSN4zXUubGukJ7Lr6yfGYnXkha+GqsJAKy
	veSg9G0GPMkWmFuuCmapAZEBF9e/6kEZdIB30ZBY4FVQwhjHX+/QE4VZ7b2B1TJCUJyZzycr47w
	SS4ueV6i6kU7nApCm7rcHE8RjAEMuHMiy7e2MGoF+
X-Gm-Gg: ASbGncuqDZTgTP27NdVIae5CSlCTJCjBabeuPqXUwjyDd+FDmFScd2K0u4GJID/wSs+
	MknThfppEJFRlDlmZTLI/FSxjFgaIcbtQeGUONfRIydCj9lGCsg19OF4JK8IRX5cWQc3PbY9hWN
	NdDrxXt8LdVFhaq/DO6akq+AODMtAMY5yM223BtvFryc+RCE1QzgEumAK0vgihbWtLgRFyNe+n1
	RkWGpY4ygpgCTsOHmX5Ezm+xF3G31tSojYZrKOcqjC1ZL98L42AZHS9LrBS4AYGI7jnFC/B94XY
	G3m49ZWhj897pU5oECiZlwcN09bjAOUrR+0l
X-Google-Smtp-Source: AGHT+IEHrDKUfiyX6Tg5Va/Bbsmq3RGuv+MIrmu/OVXPhmrJogdnKuUWHxUE1kwAo40abea/E+5yHdcptmO5e1sf0JI=
X-Received: by 2002:a05:6512:3b13:b0:57c:2474:3740 with SMTP id
 2adb3069b0e04-591d8552878mr5722862e87.46.1761064347030; Tue, 21 Oct 2025
 09:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com> <20251015132452.321477fa@shazbot.org>
 <3308406e-2e64-4d53-8bcc-bac84575c1d9@oracle.com> <aPFheZru+U+C4jT7@devgpu015.cco6.facebook.com>
 <20251016160138.374c8cfb@shazbot.org> <aPJu5sXw6v3DI8w8@devgpu012.nha5.facebook.com>
 <20251020153633.33bf6de4@shazbot.org> <aPe0E6Jj9BJA2Bd5@devgpu012.nha5.facebook.com>
In-Reply-To: <aPe0E6Jj9BJA2Bd5@devgpu012.nha5.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Oct 2025 09:31:59 -0700
X-Gm-Features: AS18NWAUSRNh675aFZJXIw7qTxvtZicID119h22vs_wRgto463TTxwR2SgdBO8w
Message-ID: <CALzav=ebeVvg5jyFjkAN-Ud==6xS9y1afszSE10mpa9PUOu+Dw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable limit
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:26=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote:
> On Mon, Oct 20, 2025 at 03:36:33PM -0600, Alex Williamson wrote:
> > Should we also therefore expand the DMA mapping tests in
> > tools/testing/selftests/vfio to include an end of address space test?
>
> Yes. I will append such a commit to the end of the series in v5. Our VFIO=
 tests
> are built on top of a hermetic rust wrapper library over VFIO ioctls, but=
 they
> aren't quite ready to be open sourced yet.

Feel free to reach out if you have any questions about writing or
running the VFIO selftests.

