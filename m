Return-Path: <linux-kernel+bounces-892737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B696DC45B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 511654EA8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203D3019D7;
	Mon, 10 Nov 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajduP91Y"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83F2FE578
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767990; cv=none; b=so8h0VcXrP2PLkdLbPGJ2ESYOe2TsMvZQViZfTGDGhpdNKzQVEwtIO7UipmcUcZ0hbsbakj9qXYOTmN6/HihAuDAL4+CCfecAAeVoCgdBU01r6yCPFWxoEIJ4uKoK0rPpK44jefvlMy70x6UQDTNkRU99wWFMuSaPPlfME2BH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767990; c=relaxed/simple;
	bh=az+zZWHYWFTbZRuwathODXO0+k5yfzm07rKQy6P5UGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOlUi0IUwjDkqq4dE/reGt+BqmVc5Lc3V22jDiSgIH6yDFjM1ucxR2r7yp7x9NI8VxOvCotSZEjIZKlJ+ukqjDlKkTpzoBoagVA1J1wNplqP2ln1r/1aP/v54iFKhLTbqyoDlfYIOKPHJjEVKirrfRO4UcHOBTyf+ZCyzgYLmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajduP91Y; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so1648137a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762767988; x=1763372788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpQaurzo67KxUNaUfM58zdtArAVNYjA4ClY5xFy4KPI=;
        b=ajduP91Yx+A6XnfDrVgzMVcRDlmWJH1a4BiBxfhlA8GuDdCZbV/QZ30fLEmhy8LegC
         tKTQs6/Dyo/+vbTPKZ1wKhUbpXQv8gIahMAf6IdwDuWuhB+5p1UO2itzGom4zmio/Dep
         +sMzwbc7BkvA5HV6XmQAoFx0768gPy657CaF/OktJqQhivPaNuzj4GCIb8iu0bZjdXAm
         i3kyRBUpnNx6K1LtcjeMWCM8N2rXn+KKc3ka3KpUnerwKA62jP/1MfMgjVKHg+c9UOXd
         m0MdbpF/UcLrAncPB+Uncs2Nt836TcrGy3l1Dxu3TqpsSV4cdzodXov2s3z4EO9yvO2w
         eY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767988; x=1763372788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpQaurzo67KxUNaUfM58zdtArAVNYjA4ClY5xFy4KPI=;
        b=tQqjOJ5xeTuDXkvHvtK6b3WFEwx1WjlPtDYrB1zU17oJliZRBpRHkX3c/w8VmKEVf+
         vCaqz3rqhD5W4rrymAFfZEz+CZqdQWHV9ZL7SDfzlEnNUY2/Mxn3G0Q7hq9cye2Oq3oi
         /tyx3bblQB5qeN1v78eFG5nEqwqA5IxjSrRmOz0jd8BQVPRQXXZytJgwwE9RvS+LKxpm
         q/MDdmS+SyCDymP1D89PvEN/vytDd6sCRrvYZpr52dPob2zdCb85uJ5crYuTKbRZgvny
         N6Y/9dJcKYJnpONybPFHbsH6Jmi5s4moqqJvDPM+k8XVXSQLU2nXv2bIDKis+k+ijt8h
         py/w==
X-Forwarded-Encrypted: i=1; AJvYcCW7uvZPBDkj5+6DI9TJJbqsxZ24i6cDsWdNhRD7Vrv9QNWxLzK6oJCe0BtgMf49q/mERmYhLijTRZk2WHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYL8ATinb5ivOJQDKbVLmeW8UNRx3ojinqmbCtoTxTl34uxAZ
	3XEXZMo3SgqPqgG99OErV+sPwG0yikvBcCqrWDFdaAixALxsdAoynMfusIBLXAu4lur3LPFgOAV
	qncx4TZtl1mXQOzJT3/i2nK1eOg+bMdvDK1qzaEn8ip7uUJdunbrm4ZM=
X-Gm-Gg: ASbGncvuVqQDkLyAnXQi1G4TkL0fel/mIcDl6vyA6zHkpZKuzagui7sH54P/qyN5bSP
	jSrD6NA9EJlgvixNBdZhY/zisaDk3WYX5UbFJokwb1a2Lg/wDJBofVMe15dn6/mU6llOtEatB8f
	kAJNwqY5AZ3Ue06kE0qw7ZKBEBCGxNOH842aTuifbW+yrpD2yZKvXphbIHx55OkJIdewZEmy9QW
	U5avIf+XLna10vwSx370ZQrYtVahYWCovQ98UDMzHeMYk85MfAUQ/5z2k/duPIJZFZONw==
X-Google-Smtp-Source: AGHT+IFmH8Uh4y6gtqai86qIqHt5uEOsGz3Va9tFoeXAycpCM+2DV5FWfARtb5KOmXgN1BSOeN6ctHKuVIQEbQjAz84=
X-Received: by 2002:a05:6830:6da0:b0:7a0:239:809f with SMTP id
 46e09a7af769-7c6fd730bc9mr4627780a34.11.1762767988096; Mon, 10 Nov 2025
 01:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024052102.635908-1-rdunlap@infradead.org> <aQNj_24YgDicCLOa@sumit-X1>
In-Reply-To: <aQNj_24YgDicCLOa@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 10:46:16 +0100
X-Gm-Features: AWmQ_bnEcCaaQUq4N0njI8uuGGE5Npz9y0Al5gMP4-EoSBPhEF-vFqf2yZLcNHM
Message-ID: <CAHUa44GU6jVwdSSkYW-QxhOJvqKrq_JTF-cW=435UiT+cgK-jA@mail.gmail.com>
Subject: Re: [PATCH] tee: <uapi/linux/tee.h: fix all kernel-doc issues
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 30, 2025 at 2:11=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Oct 23, 2025 at 10:21:02PM -0700, Randy Dunlap wrote:
> > Fix kernel-doc warnings so that there no other kernel-doc issues
> > in <uapi/linux/tee.h>:
> >
> > - add ending ':' to some struct members as needed for kernel-doc
> > - change struct name in kernel-doc to match the actual struct name (2x)
> > - add a @params: kernel-doc entry multiple times
> >
> > Warning: tee.h:265 struct member 'ret_origin' not described
> >  in 'tee_ioctl_open_session_arg'
> > Warning: tee.h:265 struct member 'num_params' not described
> >  in 'tee_ioctl_open_session_arg'
> > Warning: tee.h:265 struct member 'params' not described
> >  in 'tee_ioctl_open_session_arg'
> > Warning: tee.h:351 struct member 'num_params' not described
> >  in 'tee_iocl_supp_recv_arg'
> > Warning: tee.h:351 struct member 'params' not described
> >  in 'tee_iocl_supp_recv_arg'
> > Warning: tee.h:372 struct member 'num_params' not described
> >  in 'tee_iocl_supp_send_arg'
> > Warning: tee.h:372 struct member 'params' not described
> >  in 'tee_iocl_supp_send_arg'
> > Warning: tee.h:298: expecting prototype for struct
> >  tee_ioctl_invoke_func_arg. Prototype was for
> >  struct tee_ioctl_invoke_arg instead
> > Warning: tee.h:473: expecting prototype for struct
> >  tee_ioctl_invoke_func_arg. Prototype was for struct
> >  tee_ioctl_object_invoke_arg instead
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@kernel.org>
> > Cc: op-tee@lists.trustedfirmware.org
> > ---
> >  include/uapi/linux/tee.h |   23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
>
> Thanks for the fixes, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > --- linux-next-20251022.orig/include/uapi/linux/tee.h
> > +++ linux-next-20251022/include/uapi/linux/tee.h
> > @@ -249,8 +249,9 @@ struct tee_ioctl_param {
> >   * @cancel_id:       [in] Cancellation id, a unique value to identify =
this request
> >   * @session: [out] Session id
> >   * @ret:     [out] return value
> > - * @ret_origin       [out] origin of the return value
> > - * @num_params       [in] number of parameters following this struct
> > + * @ret_origin:      [out] origin of the return value
> > + * @num_params:      [in] number of &struct tee_ioctl_param entries in=
 @params
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_ioctl_open_session_arg {
> >       __u8 uuid[TEE_IOCTL_UUID_LEN];
> > @@ -276,14 +277,14 @@ struct tee_ioctl_open_session_arg {
> >                                    struct tee_ioctl_buf_data)
> >
> >  /**
> > - * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted
> > - * Application
> > + * struct tee_ioctl_invoke_arg - Invokes a function in a Trusted Appli=
cation
> >   * @func:    [in] Trusted Application function, specific to the TA
> >   * @session: [in] Session id
> >   * @cancel_id:       [in] Cancellation id, a unique value to identify =
this request
> >   * @ret:     [out] return value
> > - * @ret_origin       [out] origin of the return value
> > - * @num_params       [in] number of parameters following this struct
> > + * @ret_origin:      [out] origin of the return value
> > + * @num_params:      [in] number of parameters following this struct
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_ioctl_invoke_arg {
> >       __u32 func;
> > @@ -338,7 +339,8 @@ struct tee_ioctl_close_session_arg {
> >  /**
> >   * struct tee_iocl_supp_recv_arg - Receive a request for a supplicant =
function
> >   * @func:    [in] supplicant function
> > - * @num_params       [in/out] number of parameters following this stru=
ct
> > + * @num_params:      [in/out] number of &struct tee_ioctl_param entrie=
s in @params
> > + * @params:  array of ioctl parameters
> >   *
> >   * @num_params is the number of params that tee-supplicant has room to
> >   * receive when input, @num_params is the number of actual params
> > @@ -363,7 +365,8 @@ struct tee_iocl_supp_recv_arg {
> >  /**
> >   * struct tee_iocl_supp_send_arg - Send a response to a received reque=
st
> >   * @ret:     [out] return value
> > - * @num_params       [in] number of parameters following this struct
> > + * @num_params:      [in] number of &struct tee_ioctl_param entries in=
 @params
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_iocl_supp_send_arg {
> >       __u32 ret;
> > @@ -454,11 +457,13 @@ struct tee_ioctl_shm_register_fd_data {
> >   */
> >
> >  /**
> > - * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted A=
pplication
> > + * struct tee_ioctl_object_invoke_arg - Invokes an object in a
> > + *   Trusted Application
> >   * @id:              [in] Object id
> >   * @op:              [in] Object operation, specific to the object
> >   * @ret:     [out] return value
> >   * @num_params:      [in] number of parameters following this struct
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_ioctl_object_invoke_arg {
> >       __u64 id;

