Return-Path: <linux-kernel+bounces-740845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA036B0D9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423E916EE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BD2E9742;
	Tue, 22 Jul 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEa61EJi"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34623ED75;
	Tue, 22 Jul 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188048; cv=none; b=dWPFXizgsOUpRobVjv7be4jGtGZ6f1sA5m0EOOxkieFlmOZp39J8AK4qVO0QJ7wt1m8WytBVxrsQ4VZ41rNM8dG8v+IWEZVG2+CrUuuxPeN3II7NBoLQz2671diaMWSKmu36c9/WEUP/SCXoixZrlaidhX+6lLx81skaFjZ/qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188048; c=relaxed/simple;
	bh=VDLTJ4JaqkTlFkHKAd/+Wvw5xDGECLMRzDwEIjS4Kio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqupCk3BEIrUp8yQObqi25YdqBIXymLIc0WIqN84CV9OiKuCNHEEbHTIOnAf9mkNDssAGvc0FhCJEObYJB4pDqzPqW+ulHYnIop+wA6dTS17fS40dFDIB0nVFkgwxg8Te6OAzx+NWlS8jv3TJa+aXE+VY3jP2B8PDVafOE1lXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEa61EJi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31305ee3281so1034836a91.0;
        Tue, 22 Jul 2025 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753188045; x=1753792845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDLTJ4JaqkTlFkHKAd/+Wvw5xDGECLMRzDwEIjS4Kio=;
        b=ZEa61EJibNR2LKsLUWv3/dWJjUGPe0fvp5JTJaynh2DayJUaKWbcMf5a3jIcvwuOU3
         ZKTAyrk+HhuOPa/gpntXBujpDkJvwTgO3cJYdUrADuDSOXBc3wzRgrUD+BLZIIJcIVqU
         RozuFYOqJy324CmF52EG59byj5Pp96c97KrnRv1o9RWzD/eAn9oZ8GuI/vUqRin1Atz4
         kmrADUbnObRRJ/5FsXxs5Z1wi0rvgaJrAHhodK0c1N+qslLl01WPx2IfQkksLbzwrGWt
         2RArC0VzG4ozj/xRtjAiXgzpM4jKUt5LQCl2NFzJ5+Fgbjl8EqH3pi4hN/Mm7hW6X8YY
         paNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753188045; x=1753792845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDLTJ4JaqkTlFkHKAd/+Wvw5xDGECLMRzDwEIjS4Kio=;
        b=tMzUIfh61L1i1DYr2LDsGpgawMpfWA+x99SxScYi20A2cxkmqtx681r1hAv9nG6wxB
         xi9TqNOo929H65YrtMPaMV7tU7Ro3t6qhCiWH9ZsBbxX0aA4teaW9KDhOrlI9DrjFhkJ
         PXfTOcbQC1HiCMnZeMwl6aDktm2IRDdYpH+UwNaiTzD+KwX4+8/Tuz+jpRahZtjHJa1s
         e3YxiwUusDYVUO7QLs8d93euuoY9sKyXLttm1iCJtHMdPGgiyMJCaBiSK/aZymNtJsJ0
         tyVWYvzqjKRD71MxJV/NbUhQsjI8ZbVa/T2s4T0eNnqtXU7YCBC/bnGssDNhiB+p40h2
         JKOw==
X-Forwarded-Encrypted: i=1; AJvYcCUicHA5QaVKjkDt6MYoYtOsRhDiuIE1iK9RXxmNKhuZSIbnnfrL3qP3ndo56fjRqZ6viXlSFE+q0s4QVPk=@vger.kernel.org, AJvYcCV56KP1eF7DkAa+43zoHooFFo8CSRNABmfR0qxbLrZTUG+S4t2e1yQrjvqE46l65nJS/CppcGTy/vsyK+VuZcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTjZCXdbw95eovDxkNfEp+gtvSCmt3U308x6e/y7Fvm8PXXNn
	Wuc0H24AxYZfNCfQ6LgpnyfbAobwqj/hjppkT/lRfkkMpbGa/ynrRSI5fPZzD4cyLhCRVHeBwDt
	BA2zj17I+yGPwWM3+wh0786MuVLsdhYo=
X-Gm-Gg: ASbGnct4OmkYQrFWDDeB0aPqQTB0o4fjwJXNKbYWYyjdnAn5runrmGIB4VRVFJGT8ld
	rcIu1OjOuMnYMiYHv97whfha8wFbUgIsUKvNapsdnlQmCeUInOj89lmc7XHN3Zh+NooHziBtgFj
	l6B/1TLODyyVxDJk4lx4ZY7XSIlQglj0do92L4NRHLYL80v89+1PljfJy45Sm58bBifjextUFe0
	D2cm8pM
X-Google-Smtp-Source: AGHT+IFACK7o+Z26WT8LiGucLmTQRBZo/S3zz480G4PUIbrlOr/9C+t/qoGO1pdI2v+q7bfQi5GsvUvzeiPIIdCG8YM=
X-Received: by 2002:a17:90b:1348:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-31c9e6ec8c7mr14499113a91.1.1753188045545; Tue, 22 Jul 2025
 05:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com>
In-Reply-To: <36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 14:40:32 +0200
X-Gm-Features: Ac12FXxgxIjMIqIU92u4doFQQB7axsxV3ThHjftGuE0hacocSfI_djdRHTfRcGw
Message-ID: <CANiq72nvbKiWiMx6XwRyLUOWxZAEAQgTY9MdqtpjAG+kbk72Sg@mail.gmail.com>
Subject: Re: make ARCH=arm64 rustdoc fails on a x86 host with SCS enabled
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:53=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> Trying to build rustdoc as part of an arm64 kernel build on an x86
> host results in a number of errors. Looks like we're ignoring the
> -Zfixed-18 flag (arch/arm64/Makefile) at some point in the build
> process, but I wasn't able to track it down it myself. Found on
> next-20250722 (today).
>
> Disabling SCS works around the issue, but that's less than ideal.

Thanks, I can reproduce it -- I will send a patch.

Cheers,
Miguel

