Return-Path: <linux-kernel+bounces-898409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E02C553BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B4D94E18B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C42641D8;
	Thu, 13 Nov 2025 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRgMF60a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833D25FA10
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996782; cv=none; b=V9uiV9Rn5rs1ig/SlsejHI1rB0rc8OtW+fG4tSI3O1umwEiTPrmi9eRAj6OqTR5QZWlWxUt9xqtiIaxagbO/GEilMQ8CP6tUdlX0fiajuF+wSPz4rp7G0yfN75zsrG5yNPhqiOdTrH6YWRj/xhvyXy9Vd9txqfgrxt2Sm5ihGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996782; c=relaxed/simple;
	bh=7FPSBOEc5+aqrhL8867Hnsv8NNqxIjSIlUp41kin0sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6bBEp+1mbQgVhhVBWR5TYt9F1P7BP2qwN8Bu/9yq1YGUYKj1sCx/tNko+UseutzROkzE9a0UOcQOYpjSaV33TEEqtpNk0vznBExPhMWHQ5cKJoxMnkxbIi7ILcVn/Eu5fd8Vh2+1fCsRZSAVBJQm8xh8nwZVeDD6e8BwRBhsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRgMF60a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0967C19422
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762996781;
	bh=7FPSBOEc5+aqrhL8867Hnsv8NNqxIjSIlUp41kin0sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DRgMF60aFWMIE+glOLy6tGuEEI6CaI1q9H41bugnc35xJ72H79jQfF8aE2FT1AKph
	 joLJz9FjWSm3Yf4JpCHVvii/XsKRArnQ+I6wdMmDN0CVSFLIZO7O33DIQija7exv/K
	 uF/cm6FYS/qZtoAT0CMrc0zHaEM9aRO8nTA3PAzTZepHfpNwzIHrzlki4EVxE/qp5h
	 V6XJk5MQJdgFtrRrQF9RJLqUoBtvtYBjGDD8qGl/hT9ITpkCc8Kv3YJX245lYILLfI
	 ySKi6ENAz5JtxzZownS0DsW+wXU0gzN4FtJhF7WDl1syIGnhS1h43/lNfKFSLtSBcb
	 aQQ+cT5dxLqQQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso665337a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:19:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXL1u2skuKYZAX8jwfzG/i8P1sd4hp7F66l3i41B8/URQQWhvMWO77BnuN6ur12/XM/XvzmguP2gvxTjpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDZSGrvVG9KxvAJCI0unIpirWm1zKq1mBdLBZBYFocNHswzf0
	dJ8TiLCf1qTm2g50ZU9jwm0MY40mqDwfLi67gMzW4cku6VGQZ8qqsiyErZ3l3gKuzB4WIivji5i
	zGHH/mDjZY7WTSG+S1L/oMCC/dq+l2pc=
X-Google-Smtp-Source: AGHT+IH3OJZdCnys5PZEXpc+3YruRfI2mIC69GRGRXC8tf1kMdgC6Beey79mvjWhmhmETHR7O1KBhw8Tom7UH9eNUnA=
X-Received: by 2002:aa7:dcd8:0:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-64334c73405mr938039a12.3.1762996780194; Wed, 12 Nov 2025
 17:19:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev> <20251102073059.3681026-7-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251102073059.3681026-7-chenxiaosong.chenxiaosong@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 13 Nov 2025 10:19:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8o3CKcaArMzEifR+oaX2G_g3XuEjFkBtPhyO99pKQO+g@mail.gmail.com>
X-Gm-Features: AWmQ_bkew1tHJwUxtyLjNCkvCk2g3GSBubsHa87-IqewxPm-jIAhCjQH120o770
Message-ID: <CAKYAXd8o3CKcaArMzEifR+oaX2G_g3XuEjFkBtPhyO99pKQO+g@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] smb/server: remove create_durable_reconn_req
To: chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org, 
	christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 4:32=E2=80=AFPM <chenxiaosong.chenxiaosong@linux.dev=
> wrote:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> The fields in struct create_durable_reconn_req and struct create_durable
> are exactly the same.
>
> The documentation references are:
>
>   - SMB2_CREATE_DURABLE_HANDLE_REQUEST   in MS-SMB2 2.2.13.2.3
>   - SMB2_CREATE_DURABLE_HANDLE_RECONNECT in MS-SMB2 2.2.13.2.4
>   - SMB2_FILEID in MS-SMB2 2.2.14.1
>
> We can give these two structs a uniform name: create_durable.
Please use typedef to define multiple aliases for a single struct.
typedef struct {
  ...
} create_durable, create_durable_reconn_req;

Thanks.

