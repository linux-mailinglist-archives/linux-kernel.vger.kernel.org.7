Return-Path: <linux-kernel+bounces-875095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E38C1835D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E41ED4E495A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C732F12BE;
	Wed, 29 Oct 2025 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI0Hi7Ga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15792EDD50
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710064; cv=none; b=UbBpTqAENZn8X/8P55tumA5/rv308rjvpqYrdoY9Z4S0P4nl6GHwq4mMi0u8r2sj0nG6Zz3FRS2QdaLzh/bYpWcZsiou7LQZLX0ae5+mHDEhw++MtYmFYNUR3mla/StGJ0KXQZmL5CqoxUbVzkGOWFON/AmvNv1Anse5K8xB3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710064; c=relaxed/simple;
	bh=HYJAyXlItEtkjmzWIn0q9UI8lYNLf+o5ecD9Qg13pjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWedFFgFa+d+NjxA+JL86vdKlr7oyU6/yLZMua/Lcm6fZEt1ou/Q0l9uH84QfWvRBh6lqESNP4q7YEX5lOU1w5n5BGRUTZYqYlrPi+PkxFKX2wCaPHB+ol0O6JROFSLv5hNY9cRWIMUmTu9UHquzft0T+uGbbIuaYjdiQGqgA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI0Hi7Ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5FBC116C6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761710064;
	bh=HYJAyXlItEtkjmzWIn0q9UI8lYNLf+o5ecD9Qg13pjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FI0Hi7GapxlzHXfbyzhWVYjl9yWgO+dAl4IKfLskzmXxwsCnormdDUjeNFQ++uy/4
	 TKgdoXlw4a8tnsEUHt6ZkzL4ZYt4UKbflkn7qhlGNCU1urtfmZO0ErY+qw8mNa/A8A
	 bZ5/B0048JY1PoghtE6RtOPVYUH91Tx9eyFKbw22cgNytXK4GsjvHX36pJ1QwfPDiu
	 a+4+eWBJd/dkqrv6lrajnPbo9lyq0sY6uM0sUS8beqPfkzCr5opYc6RONmu1AkXiuQ
	 l0CLrpQo5mh7PNyk0TEDt1fbSK996aYQEZUetVQU9YdzZbZp/9JA+qmsW+VUFVTof0
	 DMBOn5GBvRBZA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d402422c2so1578039166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:54:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2sqhlOCiHjMBIU+o4G7QFIlWdTTxReGR/k4mlG7DG644aFctg5M7B14coDSWqdCYOPKrstX9DJbsS8Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgm8XsVMDhHWNKauaJ91xPSBgYCjtgxI4eriAvWBG2ZN6mi3i
	rxUjnJTsJMBnJHQQl0zW20oc/b+xTDQYVHOaejDa9L8OVgB6x6BiVlZ0qLSRAXw6Dj4qUtVCkCi
	nvP+bdUAp1MQPjspuGzQZ1y5SRmIwzak=
X-Google-Smtp-Source: AGHT+IH1Ig8uBUA62ai5XaFqh72uxSbyVoSyAQJE4SoR1FB1FHmF36cUsplWrbcT/C2WQNvbzYtHWrnCxFTRxV4ocxo=
X-Received: by 2002:a17:907:5c9:b0:b6d:2d06:bd82 with SMTP id
 a640c23a62f3a-b703d2dae2amr143507366b.25.1761710063009; Tue, 28 Oct 2025
 20:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev> <20251027072206.3468578-5-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251027072206.3468578-5-chenxiaosong.chenxiaosong@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 29 Oct 2025 12:54:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-KaTt1Y5gcsrWU9jrQNmyNcsmBy-XOht7L-xE=s8as7g@mail.gmail.com>
X-Gm-Features: AWmQ_bk1nzJ2ub4Y_TsifrvNWzStjgZ9baMyQE0dxpr4OIb-4PG9GqNh8QaFbTY
Message-ID: <CAKYAXd-KaTt1Y5gcsrWU9jrQNmyNcsmBy-XOht7L-xE=s8as7g@mail.gmail.com>
Subject: Re: [PATCH v4 19/24] smb/server: remove create_durable_reconn_req
To: chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org, 
	christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:23=E2=80=AFPM <chenxiaosong.chenxiaosong@linux.de=
v> wrote:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> The fields in struct create_durable_reconn_req and struct create_durable
> are exactly the same.
>
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>  fs/smb/server/smb2pdu.c |  6 +++---
>  fs/smb/server/smb2pdu.h | 12 ------------
>  2 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index 6b3503c7bfaa..3e8344fa163b 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -2766,7 +2766,7 @@ static int parse_durable_handle_context(struct ksmb=
d_work *work,
>                 }
>                 case DURABLE_RECONN:
>                 {
> -                       struct create_durable_reconn_req *recon;
> +                       struct create_durable *recon;
>
>                         if (dh_info->type =3D=3D DURABLE_RECONN_V2 ||
>                             dh_info->type =3D=3D DURABLE_REQ_V2) {
> @@ -2776,12 +2776,12 @@ static int parse_durable_handle_context(struct ks=
mbd_work *work,
>
>                         if (le16_to_cpu(context->DataOffset) +
>                                 le32_to_cpu(context->DataLength) <
> -                           sizeof(struct create_durable_reconn_req)) {
> +                           sizeof(struct create_durable)) {
Please check the specification, Which structure name is correct?
thanks.

