Return-Path: <linux-kernel+bounces-848478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3791BCDD70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66EF335639B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1602FBDFF;
	Fri, 10 Oct 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzTrdYeF"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D12FB991
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111105; cv=none; b=GftJVM9zkMn62cYyEwG/tePef/SgQavPcf5MGSmuVwCMc2E8OZy7JEGiqMOD11OVd4BiPy4QYhiQDRK/P5ZRAbkUvdYfPX8Z2GQo7BLMUHKOuSUQ43KBjEmWYT6+ZaJNVCMbS3wEUNe6sAQkooSmOLS+uton8Cp2ShfkY+0zSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111105; c=relaxed/simple;
	bh=piy9ZqSedxF7WqeXcL97LOlJi0pp4b5nk/K8R1oXA8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnfuaBMbjLubtrcYtDq5GcsCAodDvOMc6eXowdS5QCNTomZtZ12+5DpZjZEsGM+1bHsLeax3rZlvNuTZsNwMPKFWMCw1WFzqMILzhoAaIAaNdfTGMH919XIFKvD6VeVIFqP2ls1kZk5QR9b1zseAgi2iCMPgCuqvFT5LUG22f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzTrdYeF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60501806so22419727b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760111103; x=1760715903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsHYs4uIkHkI1sffpJWkCivG9hy9oHIHIWqTKpL433E=;
        b=OzTrdYeFClcNxGzDxOV9teIQ0LcwAxKm6Z+Sm97H4KmkwhAWCgumctL1tYDS9GSlmQ
         T1t5oRQUgaOyLx8jAystV0GjRQlMg6wkHu2RFsedR4+anGhJ9+qY2e1zh++lQxM9hKcD
         XZKMR0eZ4D5mQyJqjL0siBZxM/QhmblsZ9D5cB9stNya/kKloHBkFNwRw+VbSu1OAF59
         I+bugSx5y55GrwPEaMpuVyhf7cRmUzT3CSAfgBaxu+J06uhf5ZrxxmIqYGiliL0KFhL9
         NNCWWv9Qc4FMRMwQEqdQh5bC3M31f5zF7Ex/Xj0rtLl7PwTt2xBiBjMMWPD4YJCjimQt
         Y7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111103; x=1760715903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsHYs4uIkHkI1sffpJWkCivG9hy9oHIHIWqTKpL433E=;
        b=hR5S6iUqzd46vOJtoFm5y5Y1sjEziMlaCPO6iI6ODUmeFMoARb1hnq4KwwUikVw4F2
         UxtU3cYheybePJOBajXmlTeIWqatDCXBz58Q3ljAOmX1yi92pQn1ZCMu4kksK059YFSS
         9gM0HEA9S5oEq/lvUZbFIQDzp4LEFcAzw3UUuFmtW/WbERXa2pzFbHPT92U6DY6Jdmh6
         x6shg8w8ODzaHba0HgluGPrhGkc7dA/r9UWUK6R/oLFy8QYY2aA8AxhUXchetNwk21Fc
         us/qhcPJEJwi5KzSHtB9viOc0rb6bJBFjtRdMR1RH7FRmIEaFWDg2O4uPKijy6EUWQD2
         zzlQ==
X-Gm-Message-State: AOJu0YyJAt8OyRSaR7883UAgWQf15IGWh2YvnL1xYl9ALtDaCCyEHNv1
	gVcnHQmpGnxOydeauD26EbDKCrQTpYv784LtZd/s02vaVWU54p2f9twapVTc9VUinbq98QBSXeE
	vOvQCDRdqZlpO8c1iX2YreBUBMx+/6Vc=
X-Gm-Gg: ASbGnct6nCXOD1quoEesFeFJ67qiZ8/zDxD3S9yw6E+Neg7M/7A11KfScxoxNsLHLEu
	fRJaejOk9k9NvAf6lixkCQQO2aXLEKN9NDGRyilLb3j0yzJMuL95OJiWfnozZS+iEAYG1tYjrHT
	BgQLzGHXqioove5ZMI301ZDMCZSpNUjUeU0Kn92DKGm7GDIV1yVXEZuouCM8IDV2ihVHqxTK0Ny
	oFyRRMrrf3MNY2W8H9ysdjH
X-Google-Smtp-Source: AGHT+IGxCxtXnllK78fJlfJY/bSfY4HfkDNUqCjCz/Ww5zmauzu8GFnXbB6t5M8TRaeAiefmOPiNjrSlXzvK+6pC04Y=
X-Received: by 2002:a53:ba85:0:b0:633:a326:3b07 with SMTP id
 956f58d0204a3-63ccb8d82cfmr7959488d50.24.1760111102603; Fri, 10 Oct 2025
 08:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
In-Reply-To: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 10 Oct 2025 16:44:51 +0100
X-Gm-Features: AS18NWAlQZpTS30VoVGatJslkKbpukKpiNdX9vYjqF3r78Zk02CmXQdCM21jgaY
Message-ID: <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 15:24, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> The inode mode loaded from corrupted disk can be invalid.
> Since Boot File System supports only root directory and regular files [1],
> reject inodes which are neither directory nor regular file.
>
> ...
> +       if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)) {
> +               brelse(bh);
> +               printf("Bad file type (0%04o) %s:%08lx.\n",
> +                      inode->i_mode, inode->i_sb->s_id, ino);
> +               goto error;
> +       }

Thank you, but logically this code should simply be inside the "else"
clause of the previous checks, which already check for BFS_VDIR and
BFS_VREG, I think.

--
Tigran

