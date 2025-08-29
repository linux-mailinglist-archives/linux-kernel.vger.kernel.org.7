Return-Path: <linux-kernel+bounces-792291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED08DB3C265
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7330584096
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6405310630;
	Fri, 29 Aug 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUbKsiHt"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0813074BB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492024; cv=none; b=heIMRA+dskdDihsSKSy8oDsiNlObI1l2GyAjjVt+3DrqSRYLZ3cZCeqnp5pdT7jZh1i5muldWy/DjKLsijk/RGa3xmm5Dm54cJMTt0WLLmjDlPOIZLmrlQHw5V2psIe7kVNK4E3MO+wvvv7sHUHGuyPFkDCBF2vL3L41L26Ibow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492024; c=relaxed/simple;
	bh=pQVsmzoOprIrtFBI9BlNE5r7BhowevKX3KreMCOu48M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy//8wJtCNoaiCFY/9+0B4/Twiwb6t6y5X/FjlbWBp6vaX2VjgfWJtfTW4ZxehHwEKav+PW4e5Dial3t+WhTa2Uf3NcUh61gWegLryh/UQd18Lt+4bzS3L1xeMdz/5AmNjO2s9EyS7Z+QjNqrFiD37oogJAZnTABf4aK/SZxTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUbKsiHt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4716f9a467so422990a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756492022; x=1757096822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkDLHFzMwhGrjPg06GqQv0+K8YzczfW4YoD6Re0s0a0=;
        b=QUbKsiHtq9QvNCxsOZ80HkuaGN2JBfp8BSzappsrW8lIZH3f0mvND+plQhW9d9XtNd
         +hA/llavCbJXonleyJVTs41412x/dp5Om+EBgeo5H7/7VGrghgarAq7xouNFp7yWl5xk
         8qzubJyR10VZ7odyHFNA4J/TWVIT0C1J+byE1L9KWdCDpkN+yGOl6YG2QSRufYhe2p2q
         qUDueHC9BJhOdHo3oG8ItGOqOGodDl5VWKiI2OzqNlaPjjeft/n3QGoPU7HJPyFeFKZI
         TlLBhppxnnBNvxRAf8R3aWBF4JOEePNT5+bZ8Efp5lb2xmK6ZciplkBLN06rQk8B4U8R
         amIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492022; x=1757096822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkDLHFzMwhGrjPg06GqQv0+K8YzczfW4YoD6Re0s0a0=;
        b=Ke55adxIW7lEp1pWE7W3PE9mKnqpkZJVWPG1tXRlGlM0SSTOJvAfx462WJUeQ5XL+9
         vE/KeTJSSalqkqYNo5SQMfuqVNog34sezzrYGO0BxuxWbuxDaLFd8/EFJGMUtNSfqF04
         u6l1/uivEMkWouODlpk05iUD1vQZgU7O/6v4SJVY/Xesjr3d8DIU4PgM4BgNNJ9aH1Vl
         b/CJiSo7yXQEz1xLf+mII2yVrGJ3RQcjIy2pKyeRhDHs20KnOQjITkqIaWSJApQ21XUr
         Q3sTzoZvW0ay+L2YT7Dgh5HxD+bPhyesyoYKhtvGQF5UPAnMH7mJV2OSu0flTVX+2gss
         YFjw==
X-Forwarded-Encrypted: i=1; AJvYcCX8/uS2rp2dCxiFtQlAwgQ87ERFqjgtDMYfoWWIhfruylCRZxHtXc6etPL5ZDSeVxYOVBpfX56uc1lKo/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YygR90Aagz7XvtVBtXDJbFvJ99Vk1JiDn5KgiNZ/MIwdJWhIs5H
	+xfBATPMPliDe0E0ce8gZ2F5/0hcuROLp1LTMkqVL5jsVd9zVcOo8arzb7XLOZibPnGgkTgI0LU
	cZigWAikTGqZFGYOejwGguZb1ezLRMRA=
X-Gm-Gg: ASbGnctZszEdZQI+jhORNr/HPrYMimreqFyc+qXzeosLk0bRv50fgy+O6nKYulUuN62
	euXjUvtixSuFUrHtXuVmoXwNmuETA7LWR0RIzSO6/y0HMlEwMXfIRJW++4jaeit4cQWbW43jMop
	T/R0l33jk32PDW8jnNF5bci4gfiJO0xEAtpPq+FKxXi9DG5MNFh4SgUjoYhGwroEwVeb97Oa6/q
	J9l0vA=
X-Google-Smtp-Source: AGHT+IFaWgOD9by+SQ/8OLiq6kJGXw7bUcexKwbwE1tkiknVjzj0JvoqLxDv5KO9XTlV8qM2PQy9fxP6box6128CsLk=
X-Received: by 2002:a17:90b:1d92:b0:327:e34e:eb01 with SMTP id
 98e67ed59e1d1-327f5b87d56mr1856537a91.1.1756492021824; Fri, 29 Aug 2025
 11:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
In-Reply-To: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Aug 2025 14:26:50 -0400
X-Gm-Features: Ac12FXwPhh5l0LhWYYCLOfE636IYJClXvYP9fxX_dVOB1qxyhYB1RRM4ov0IJYA
Message-ID: <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:53=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> Heya folks,
>
> this flood happens with plain 6.16 on my workstation - haven't done any h=
w
> changes:

Have you updated mesa?  Looks like a userspace change.

Alex

>
> [   29.094609] evergreen_packet3_check: 115 callbacks suppressed
> [   29.094615] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106737] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106740] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106742] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106745] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106747] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106750] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106752] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106754] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   29.106757] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.579786] evergreen_packet3_check: 29 callbacks suppressed
> [   52.579792] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591825] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591829] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591832] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591835] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591838] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591840] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591843] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591846] radeon 0000:1d:00.0: vbo resource seems too big for the bo
> [   52.591849] radeon 0000:1d:00.0: vbo resource seems too big for the bo
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

