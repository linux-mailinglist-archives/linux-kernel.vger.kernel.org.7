Return-Path: <linux-kernel+bounces-878287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4CC2030C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD4B3BB400
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A235471E;
	Thu, 30 Oct 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXaka5zy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4D2D4B57
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829892; cv=none; b=imkpn2QD0NvFq+TDEL7OT4s5i2p5C5vQeWQcMOiR7nR7xoU89Sfj4dJ3/f2Dxyos5etgIiFay2QIDtyEJrket77EfZmt1wQDYluvV/oqUxALg2vndmpOQ+ewQOQaLCgjyvkruZcZ23eto6xcTyaUt+J5Xjt0EskLMe+8PdM5i6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829892; c=relaxed/simple;
	bh=RAuD9U2XDmp39OPdTP0KWRm2i+jlT1G4sL2XCp8RTOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR9luq8BB4VVwXFhzH4Tb5d9qnEqY874R+auEQT5wEzWLpanC5RpJvLGxj5yVRFxLdHKK/QSvcKduHHgITSADRX+IobYZPGv5JRrniUAtaD7kHT3CPZ29h8h+ScZz6jjvZxm8qHsr/dj1rAFt9T1LaMsBBaFTd0n43K2HueS6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXaka5zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7DC4CEFF;
	Thu, 30 Oct 2025 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829891;
	bh=RAuD9U2XDmp39OPdTP0KWRm2i+jlT1G4sL2XCp8RTOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXaka5zyAyLBdMBkWOkfBtjx13poW/NiuVOs5NiM2lWHLQ2lDiNztq55Dv+wNWs6r
	 EHTuR+rahGnfcs4UNrUMIDD2Z4yiHvs3Jn9cCJrNo+lp1WwLTdQvhVl/8xHeGykOb2
	 TQUHjkxwadEG57bZ1/OdCl1Q81ubY82FZFCM643MuJcoprs7G+aNl83JAIyR61UDFi
	 tUN2WzqH4/zyR5XdXykqwiKoYrQfOK8iXefcsnG1n6LwXSrtGZXeDJX7mfJxpvVhzt
	 SAnQEwVLbCf+bJReUxbAVgXYsu4nOfjnnXVyccrLEuAvB9cfP/NWaBZQvAy+8Grmwm
	 TxvOOaoeGhfwg==
Date: Thu, 30 Oct 2025 18:41:27 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: <uapi/linux/tee.h: fix all kernel-doc issues
Message-ID: <aQNj_24YgDicCLOa@sumit-X1>
References: <20251024052102.635908-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024052102.635908-1-rdunlap@infradead.org>

On Thu, Oct 23, 2025 at 10:21:02PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warnings so that there no other kernel-doc issues
> in <uapi/linux/tee.h>:
> 
> - add ending ':' to some struct members as needed for kernel-doc
> - change struct name in kernel-doc to match the actual struct name (2x)
> - add a @params: kernel-doc entry multiple times
> 
> Warning: tee.h:265 struct member 'ret_origin' not described
>  in 'tee_ioctl_open_session_arg'
> Warning: tee.h:265 struct member 'num_params' not described
>  in 'tee_ioctl_open_session_arg'
> Warning: tee.h:265 struct member 'params' not described
>  in 'tee_ioctl_open_session_arg'
> Warning: tee.h:351 struct member 'num_params' not described
>  in 'tee_iocl_supp_recv_arg'
> Warning: tee.h:351 struct member 'params' not described
>  in 'tee_iocl_supp_recv_arg'
> Warning: tee.h:372 struct member 'num_params' not described
>  in 'tee_iocl_supp_send_arg'
> Warning: tee.h:372 struct member 'params' not described
>  in 'tee_iocl_supp_send_arg'
> Warning: tee.h:298: expecting prototype for struct
>  tee_ioctl_invoke_func_arg. Prototype was for
>  struct tee_ioctl_invoke_arg instead
> Warning: tee.h:473: expecting prototype for struct
>  tee_ioctl_invoke_func_arg. Prototype was for struct
>  tee_ioctl_object_invoke_arg instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: op-tee@lists.trustedfirmware.org
> ---
>  include/uapi/linux/tee.h |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Thanks for the fixes, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> --- linux-next-20251022.orig/include/uapi/linux/tee.h
> +++ linux-next-20251022/include/uapi/linux/tee.h
> @@ -249,8 +249,9 @@ struct tee_ioctl_param {
>   * @cancel_id:	[in] Cancellation id, a unique value to identify this request
>   * @session:	[out] Session id
>   * @ret:	[out] return value
> - * @ret_origin	[out] origin of the return value
> - * @num_params	[in] number of parameters following this struct
> + * @ret_origin:	[out] origin of the return value
> + * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
> + * @params:	array of ioctl parameters
>   */
>  struct tee_ioctl_open_session_arg {
>  	__u8 uuid[TEE_IOCTL_UUID_LEN];
> @@ -276,14 +277,14 @@ struct tee_ioctl_open_session_arg {
>  				     struct tee_ioctl_buf_data)
>  
>  /**
> - * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted
> - * Application
> + * struct tee_ioctl_invoke_arg - Invokes a function in a Trusted Application
>   * @func:	[in] Trusted Application function, specific to the TA
>   * @session:	[in] Session id
>   * @cancel_id:	[in] Cancellation id, a unique value to identify this request
>   * @ret:	[out] return value
> - * @ret_origin	[out] origin of the return value
> - * @num_params	[in] number of parameters following this struct
> + * @ret_origin:	[out] origin of the return value
> + * @num_params:	[in] number of parameters following this struct
> + * @params:	array of ioctl parameters
>   */
>  struct tee_ioctl_invoke_arg {
>  	__u32 func;
> @@ -338,7 +339,8 @@ struct tee_ioctl_close_session_arg {
>  /**
>   * struct tee_iocl_supp_recv_arg - Receive a request for a supplicant function
>   * @func:	[in] supplicant function
> - * @num_params	[in/out] number of parameters following this struct
> + * @num_params:	[in/out] number of &struct tee_ioctl_param entries in @params
> + * @params:	array of ioctl parameters
>   *
>   * @num_params is the number of params that tee-supplicant has room to
>   * receive when input, @num_params is the number of actual params
> @@ -363,7 +365,8 @@ struct tee_iocl_supp_recv_arg {
>  /**
>   * struct tee_iocl_supp_send_arg - Send a response to a received request
>   * @ret:	[out] return value
> - * @num_params	[in] number of parameters following this struct
> + * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
> + * @params:	array of ioctl parameters
>   */
>  struct tee_iocl_supp_send_arg {
>  	__u32 ret;
> @@ -454,11 +457,13 @@ struct tee_ioctl_shm_register_fd_data {
>   */
>  
>  /**
> - * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Application
> + * struct tee_ioctl_object_invoke_arg - Invokes an object in a
> + *   Trusted Application
>   * @id:		[in] Object id
>   * @op:		[in] Object operation, specific to the object
>   * @ret:	[out] return value
>   * @num_params:	[in] number of parameters following this struct
> + * @params:	array of ioctl parameters
>   */
>  struct tee_ioctl_object_invoke_arg {
>  	__u64 id;

