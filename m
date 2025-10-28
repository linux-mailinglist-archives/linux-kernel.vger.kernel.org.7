Return-Path: <linux-kernel+bounces-872990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08378C12CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A86CB3542DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E327EFFA;
	Tue, 28 Oct 2025 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ierMa/CH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED526E6E4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622973; cv=none; b=t6cXsr+CzaKA3OZO/YtSzhSoEbj4mM5GZ5DVcgGmKFJHnifPMLrWxONQ3RhdCMoaIOphEjrP4/5n/diDhQj9csbwHKhL6+6M0eXXadiR57Nzitb8lOSk8NSnPB5GClwDBPfZxWnFSlSXwD83aiH5FiUzPZFRzI8tcH2oGgTGhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622973; c=relaxed/simple;
	bh=EZxjcoS5qdrAwcRhEUNyB2nv+HkIt/HSRelXLGyxR/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7WZpdy5TmnAgZo2fFdwaJ8lPmIEuNDZDWyv+SZWbJRwc7U+ETYO8wkg2KmT+TU64HHTfMsl8WXiqa6/8CB6/p9GE+yFt3Y46XBWboF12oW4DyFuqPC5CJiy2PMI0Ewo8s5E0W59x5JghR8YmB7yfoE6hm5otpONvLQHyZ6WBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ierMa/CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E0C16AAE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761622973;
	bh=EZxjcoS5qdrAwcRhEUNyB2nv+HkIt/HSRelXLGyxR/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ierMa/CH8VlCvIPJOWKek05ltVtYpu9g7DK/CwkSnKOz1xNfEaz73CqELlo0UIIu4
	 pPohP2ddYLgwhEwB2hfCnvx9RjcfYbwspT3UcSmwGDnu3pn8sJ7UOyqu1SeFyyCiyo
	 i6eJSsXqUZiqTHnM0lx9KcOqZIOnWx5xkpk8FFeh/KRHRqGKj7kP4kHmCEGHFMd+Qb
	 bYloGTW+9tdRpbyyvck++lzkItQ6UY4tUhvXnGbIewMt0SJ1OjmTpzFwdSSym7s3dE
	 xjrQYupv+bUtc6/sK0aaQ+L1kxQ99v/H+cn1E65NTE6EHVW4MlyZ+Id16WeZIbQIKQ
	 KD1xFjNirF/fQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so10459395a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:42:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlbAgbNytylspUh+lDRBwcgsmoe3CLs3YFkoBY6WWSqVkjDU/KLhBePtKp5YfAtxeIlAAGPXRHwdqUt2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuszB1eVd6k9Pe/m31XLv/FkcTfGXjTvppTINjiQKXxjX1k8Ci
	ehWd3afLEaWVVCOzsd1JqdQv2VoWjX2aevS9z72EiH6y8zUggj+AQkguw7i/Igd5GUik9XLmwIT
	ABzJNYVR7MU5INJXzrdL7jk0L4XaOEyQ=
X-Google-Smtp-Source: AGHT+IE0Lwz1JCRI0jHDYh0j09hHq/x9gpT0MXwMZfzZOvhhSbGEAsEW7sSrOe5WEAS9zt2ERS+jZl1qvzny5tkooLw=
X-Received: by 2002:a05:6402:1ecd:b0:639:6bc8:c7bd with SMTP id
 4fb4d7f45d1cf-63ed8372b59mr1779428a12.15.1761622971503; Mon, 27 Oct 2025
 20:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev> <20251027071316.3468472-6-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251027071316.3468472-6-chenxiaosong.chenxiaosong@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 28 Oct 2025 12:42:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_u5+p5hjvQey+TM8w4+P7aN7zSfwDbrUKRtbwx4vtyDw@mail.gmail.com>
X-Gm-Features: AWmQ_bk529JyA7cBhMnSJ-zScZU08IV0EpoThk9A1m56Np09T_41LA9OSe8XU2M
Message-ID: <CAKYAXd_u5+p5hjvQey+TM8w4+P7aN7zSfwDbrUKRtbwx4vtyDw@mail.gmail.com>
Subject: Re: [PATCH v4 05/24] smb: move some duplicate definitions to common/smb1pdu.h
To: chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org, 
	christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:15=E2=80=AFPM <chenxiaosong.chenxiaosong@linux.de=
v> wrote:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> In order to maintain the code more easily, move duplicate definitions to
> new common header file.
>
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
ksmbd does not use all smb1 pdus. Instead of moving all smb1 definitions,
move the ones ksmbd uses to smb1pdu.h.
Thanks.

