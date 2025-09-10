Return-Path: <linux-kernel+bounces-809500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F741B50E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC34E3A09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58C3090F7;
	Wed, 10 Sep 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VznqBOLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765C3090DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486585; cv=none; b=qNM/doDlK5pfBEYCGVrc2T59Mj1rLE0eHwSOYp5I4WgDA9EX8/uceyOrNqW84RicP6ZNxcBTdRMQGurZNqcbYfyTM8UisCf0+STesTYE+7iXU9EPmIAmXbma8fI9Bs60rkLqUFi1rrDJlcCnezNc32A+GKjjKRvD5KyQhxjQGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486585; c=relaxed/simple;
	bh=lYAbatb9ngtm3i8mRxAijmD77j7Pr6erMeCNosuRHCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb6z79Lg7iQ6AFQIFzmFlrLbDwBO2zY14HUgmdBoqxK9Iypc7vmEj0Hl6HCCsM2Ae53th9jmz1zPirz5EQEZXK79Gn5PSgkJiJHrLJ2jIPxDIGLF4Nhh5K4A01QyHocTtCZZaFuLJRxNGUOw8299AjxkFVgv0slbtF1lGyb++vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VznqBOLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD3CC4CEF5;
	Wed, 10 Sep 2025 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757486584;
	bh=lYAbatb9ngtm3i8mRxAijmD77j7Pr6erMeCNosuRHCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VznqBOLREG2nfeZcCHgLqi2ehIyvr+HVu2usl1lZAyN7Q8zpR1mZzsyobbJMc+HdO
	 9RpMQZeWhMNDtrz0rEDVH1caTovqHD54pUc/Xm4JqE4BLTxc/U5l5gZL5SIA714D73
	 vcClDkKpInZs2I30h07KqjRFI4icGTI54Cus0clCycqoxJCPd8Pyd9yknhH793RrF+
	 is2ucSHBhb3GHwZajrtoNFVvAqioIYpAXgAmSVoaTENs/VT/TNzuCZnZXfDaFFEf9k
	 f1/duOsslwR4ss/lSmrhkYFpifoQqqUdYFe+/PaeYIEiI212L2qf97aKuBFi+KmcBV
	 Ilourda12o6pQ==
Message-ID: <dbb5a124-4947-491e-8903-faa18e0e5bde@kernel.org>
Date: Wed, 10 Sep 2025 08:43:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vt: add support for smput/rmput escape codes
To: Calixte Pernot <calixte.pernot@grenoble-inp.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Calixte Pernot <c@lixte.email>
References: <5002d4f9-4999-4a84-9329-edb20098fd7a@gmail.com>
 <20250909202629.9386-2-calixte.pernot@grenoble-inp.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250909202629.9386-2-calixte.pernot@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 09. 25, 22:26, Calixte Pernot wrote:
> From: Calixte Pernot <c@lixte.email>
> 
> Support "\e[?1049h" and "\e[?1049l" escape codes.
> This patch allows programs to enter and leave alternate screens.
> This feature is widely available in graphical terminal emulators and mostly
> used by fullscreen terminal-based user interfaces such as text editors.
> Most editors such as vim and nano assume this escape code in not supported
> and will not try to print the escape sequence if TERM=linux.
> To try out this patch, run `TERM=xterm-256color vim` inside a VT.
> 
> Signed-off-by: Calixte Pernot <calixte.pernot@grenoble-inp.org>
> ---
>   drivers/tty/vt/vt.c            | 58 ++++++++++++++++++++++++++++++++++
>   include/linux/console_struct.h |  3 ++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 62049ceb3..d9e4eb3f0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -141,6 +141,7 @@ static const struct consw *con_driver_map[MAX_NR_CONSOLES];
>   static int con_open(struct tty_struct *, struct file *);
>   static void vc_init(struct vc_data *vc, int do_clear);
>   static void gotoxy(struct vc_data *vc, int new_x, int new_y);
> +static void restore_cur(struct vc_data *vc);
>   static void save_cur(struct vc_data *vc);
>   static void reset_terminal(struct vc_data *vc, int do_clear);
>   static void con_flush_chars(struct tty_struct *tty);
> @@ -1344,6 +1345,10 @@ struct vc_data *vc_deallocate(unsigned int currcons)
>   		kfree(vc->vc_screenbuf);
>   		vc_cons[currcons].d = NULL;
>   	}
> +	if (vc->vc_saved_screen != NULL) {
> +		kfree(vc->vc_saved_screen);
> +		vc->vc_saved_screen = NULL;
> +	}

Yes, that's the bug. (I am not sure why are you sending this?)

thanks,
-- 
js
suse labs

