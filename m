Return-Path: <linux-kernel+bounces-795409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8939B3F198
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F001890CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4526525A65B;
	Tue,  2 Sep 2025 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OoRY8wIy"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94D1A0BFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756773282; cv=none; b=V6O3J2+jPZNOiUkRcqQzsXba0md/hRemL6iQrCqx+JAR9s/4NR6iIzFb0G1s2ZWi8K0eFSCJhYKJrSJ6K4rCMs9hbhpWZaN65fvo7vMnOzTk+OdYc2b6gqxh0QpzFC/gbgha0WRlmSn+W4Yc4CfD1Zi8dzzJ+krwb73/5lGo6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756773282; c=relaxed/simple;
	bh=i2TwLbUOZ7KKhjJaNlnfn/MAVPp+frhXjXk751S9q+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVbB1h3k4Xj1DX4DpRxYATTVB0P5RAoJjoNAWnNdxknlJbJ08QRKiiF0/krZKA5OZPRyB5mtgYuKTefdtSA4kf/puhX+TO2tY023Gd8zt0uou7b90Xl/8HedA4zcRTHQPLDbCZVdkduvNDOduXQxJFBUDfTC4IepDaLnGcH1XC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OoRY8wIy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b14d062acso422885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 17:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756773280; x=1757378080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8mvun8yKhCfQpa9qewR7P5clmDieHyCmdu979s3y2I=;
        b=OoRY8wIyzG4PkAAhXncLYAYhNaOa4Mi8mTnlNSe3ZLRJMAhFQ5ZUfq0zTZKFmjUPqH
         +xABm8OPUqmJMw6JuRZcWB1BlzUg2u5H8BCdSQO2OW9l9uzPZhBfbfAgnB/JcSW+XpGp
         1Z8BJgV671k7Pz2jl8NJfxwkHI7y9k2PhI9SP1J7YO/T4Pl0iAooBRYsF4aCoPZn0lHR
         ekk4UrMGTWudtt7IyUmwy2hX6jM5C4F0ISx/0nERiLZY38COHvJK8jeWIS4XD2jDMTKW
         a887IILx7bNDem22poJH2ON7pszNhFWKi9lipJkFl0/35++GVgd5lSooSwRjK+Wo5UUQ
         qppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756773280; x=1757378080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8mvun8yKhCfQpa9qewR7P5clmDieHyCmdu979s3y2I=;
        b=aqnzi6zIr2QyEk4zNneWrKmZNwRJUmOvHcCIvZfCWJsm4XuGwB4VnulvIVVKmReXJ+
         NXH0Ov2B5zE9XIzBa+R4DcT0j5PrwV83oVcxAWbSNKEJIDnrX7E1hkoYkArXuCkt7n40
         3yfE4Q7ydJuw4vDFxSyx0OhuyxIIc+C7VPG5d8VSvFQnYGkrD+Bpt+q9oHVjy7uEuCnC
         2tWDnnXn0elaNETHRQEGpmIyn0U3JJCohtLWu4Ea7ALbgoDT4OV927vIf0D1jPnpq8LH
         B4o4umOBiCtK7YbHqxZzcrDbLDbwF4fGWriwecx3YDi8vkdCHRZljgpmoHjnyzs/KVYO
         ax4A==
X-Forwarded-Encrypted: i=1; AJvYcCVbxiP7at4yHNZTQQ/g5QdJ74fAQFiT0O36X2fcQettKC7sQc26tysFVrXvv1HY6I/CdL/QoOwJkZHyxmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+222BdQAg3PqnQfsnR2xhXpbYEfroUJYMhS9lNAxMQuTKWptH
	0uwPzZHuV5nA6S7PkwgB12pWOrEDs0nCdayoUno8A5FunzobKWbMJOBTwZYnIu5DcR4yzFzBT0H
	YhtzH3neycrRZ9eA4JcymurLedFs8wpXRvpnpgie/NQ==
X-Gm-Gg: ASbGnctQa4XrM0RlQdW1JhJe3tP/UUVPtZE3E9R7sPjsDG/RuXfFaSU848KHaKW3M1a
	yW5iWeEs2Y0H4YvpEzOORHOGNs8CK6OM6iLqa6kCba81Byd38xVoAhHJYUL5ULDjjRJKpx6JhGM
	wuemx9ypQHr/mWpxZP+hi7jCLBdeCVkw4H99xURq40yUXXzsoKc5GpKtA8Vjaav4QpX6TGAA6NJ
	TgvsVbPmxgH
X-Google-Smtp-Source: AGHT+IFJovkcgVU9yQU7XG1YPIJ6Tz9WQAzuQ418KGmVw1e0tLC/wyvbcQu5zlimXbiJZtr/sKrA+cnAXZX6n1RZSG8=
X-Received: by 2002:a17:903:22c6:b0:248:dec9:4d2e with SMTP id
 d9443c01a7336-2491f1386ccmr82044385ad.7.1756773280254; Mon, 01 Sep 2025
 17:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822125555.8620-1-sidong.yang@furiosa.ai> <20250822125555.8620-3-sidong.yang@furiosa.ai>
In-Reply-To: <20250822125555.8620-3-sidong.yang@furiosa.ai>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Sep 2025 17:34:28 -0700
X-Gm-Features: Ac12FXw_gmrSGrZTI50hCN8j16GN0dek7Ml8OXCaKqeJQoUHhKt7q785ZmT7eGk
Message-ID: <CADUfDZpsePAbEON_90frzrPCPBt-a=1sW2Q=i8BGS=+tZhudFA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] io_uring/cmd: zero-init pdu in
 io_uring_cmd_prep() to avoid UB
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:56=E2=80=AFAM Sidong Yang <sidong.yang@furiosa.ai=
> wrote:
>
> The pdu field in io_uring_cmd may contain stale data when a request
> object is recycled from the slab cache. Accessing uninitialized or
> garbage memory can lead to undefined behavior in users of the pdu.
>
> Ensure the pdu buffer is cleared during io_uring_cmd_prep() so that
> each command starts from a well-defined state. This avoids exposing
> uninitialized memory and prevents potential misinterpretation of data
> from previous requests.
>
> No functional change is intended other than guaranteeing that pdu is
> always zero-initialized before use.
>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>  io_uring/uring_cmd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 053bac89b6c0..2492525d4e43 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -203,6 +203,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe)
>         if (!ac)
>                 return -ENOMEM;
>         ioucmd->sqe =3D sqe;
> +       memset(&ioucmd->pdu, 0, sizeof(ioucmd->pdu));

Adding this overhead to every existing uring_cmd() implementation is
unfortunate. Could we instead track the initialized/uninitialized
state by using different types on the Rust side? The io_uring_cmd
could start as an IoUringCmd, where the PDU field is MaybeUninit,
write_pdu<T>() could return a new IoUringCmdPdu<T> that guarantees the
PDU has been initialized.

Best,
Caleb

>         return 0;
>  }
>
> --
> 2.43.0
>

