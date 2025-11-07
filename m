Return-Path: <linux-kernel+bounces-890833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B9C411E4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6583AE56D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861633B6C4;
	Fri,  7 Nov 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJdGsPud"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14577339B30
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537315; cv=none; b=QxN3jqCkmXfRZuigIzwDqQfUfmhAUEsIvnlF3IHxR1TWSBvpNHAGm8MwhWjaPz+hu2Sv6mTZTcPbh0xi3ng9/DHtppz3eqnnXA6JHo3iHr1B4mXvaSuH3Ha91//JF09ypUPa8ODEGyJF14/9TvxKP9oJDPnnkEj5g3IrC8IHnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537315; c=relaxed/simple;
	bh=27sClCZAP86nl/8ps9gQKF3tyhUrrL9Eo5KOucNwwgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9X/52I5eaz04W93qY869m3wswCrcoSY+9Ftr+W4JWpLB4CVfU5/1ivu8vmvLUhyjMRIpIKWt/wrseL14JlX03dLI5cHVBVYx3d99RfipTl6TvCHaTjPVc4OXytHQZZil8VfxJS6yBenCb+J0OXxhNgC8s9xrYin4/6aUCLtUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJdGsPud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95163C2BC9E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762537314;
	bh=27sClCZAP86nl/8ps9gQKF3tyhUrrL9Eo5KOucNwwgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bJdGsPudR/2Kj7f0mh2V+Iu9ZCmEuowGNMONvo13Z7d7uD+JLZ7pk854+0WKdZ9rE
	 voMj2qN+D99bzLa77D3lfgaJAecGsdlAhiVcekfRWOGYLHPjtM2n+YuUJxRIVido01
	 r7koGSIl3K9rPG0WThA6fxLwixJap9XRmuLg4v4vttMmWx7v3Z4voIE37BXjnOizcb
	 3gS4fec3IU5qPZGDf3FlqlAoH7NYDM8Wq5rhgTLE9DdD0bAV3yAwbCNZwWJPIcu55U
	 PXXRQ2N31GSlRV9QuH1DT+EUX7KnzmDtHEuGdMJOI045f5XmCuINckHvRZBlVH2MzF
	 zDGRGUTvoZLAQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c6dbdaced8so686048a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:41:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVY6q2M8Uy+W8ujSrcD5WyGPOEH9ZDrfIXgI3DLpOhoALvOyMsZbkgg0DqvtT0Mi1gjBGzv6Horty3YVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNaW1Is+t4Ga+71MGA/ScR7g9avStu+6J8p42tawhp69oXEcp
	u9DKFc/ERE38+avxADvAvgjaKvmp3GD317gL8/1zl9bJ30hNkFS0h/tUhMe8RzQe6qESoeBCgnJ
	zuB1MGuZ5Z8eFni3EkKAcqg5Xw0iQTxA=
X-Google-Smtp-Source: AGHT+IFKw5Gp9vlatOw0Vo6xHmwdBnWOpoJYGtd55ptW74cKfpz+5iLRn+uGNfcY6XT8QgzLGYWzgE1OQqub02oDfII=
X-Received: by 2002:a05:6808:320f:b0:450:2de:27d9 with SMTP id
 5614622812f47-45015f72eecmr2610896b6e.67.1762537313325; Fri, 07 Nov 2025
 09:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107074145.2340-1-gautham.shenoy@amd.com>
In-Reply-To: <20251107074145.2340-1-gautham.shenoy@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 18:41:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jS_uNRz=3ZQQLsChf2V3UUvhf6BZ+MBL0WMv+rcW4H6w@mail.gmail.com>
X-Gm-Features: AWmQ_blVBBEBRxkx2IRLNsv6l61K3qx5JUiJQfYFp1ZgixZq9hOXBe3IWYvBxqo
Message-ID: <CAJZ5v0jS_uNRz=3ZQQLsChf2V3UUvhf6BZ+MBL0WMv+rcW4H6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] CPPC/amd-pstate: Fixes to limit actions to online CPUs
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christopher Harris <chris.harris79@gmail.com>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 7, 2025 at 8:42=E2=80=AFAM Gautham R. Shenoy <gautham.shenoy@am=
d.com> wrote:
>
> Hello,
>
> This is the v2 of the patchset to restrict certain actions to only
> online CPUs instead of present CPUs.
>
> The v1 of this patchset can be found here:
> https://lore.kernel.org/lkml/20251105143851.4251-1-gautham.shenoy@amd.com=
/
>
> Changes between v1 --> v2:
>
>  * Picked up the Reviewed-by tags from Mario for the first four
>    patches
>
>  * Picked up the Tested-by tags from Chris for the first two patches
>
>  * Added a fifth patch to fix calling of cppc_set_auto_sel() for only
>    online CPUs in the amd-pstate driver code (Mario)
>
>
> Gautham R. Shenoy (5):
>   ACPI: CPPC: Detect preferred core availability on online CPUs
>   ACPI: CPPC: Check _CPC validity for only the online CPUs
>   ACPI: CPPC: Perform fast check switch only for online CPUs
>   ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs

The above 4 patches applied as 6.18-rc material.

>   cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

And I'm leaving this one to Mario.

Thanks!

