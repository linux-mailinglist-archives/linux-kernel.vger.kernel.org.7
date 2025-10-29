Return-Path: <linux-kernel+bounces-876794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA0C1C5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B7194E5B54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF28346E7D;
	Wed, 29 Oct 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph3/Qjco"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436E274FEF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757265; cv=none; b=q/5rQPo/jZdMVS34QUj5YUh5HIAkPwIjlUK/wK9FurkqRdtD5dsGvXo9UHuw1OvFSi213sjA9ir0TaVggNxaKtxEFxVdyZwP4LpzGyTcmcuNS8OjZ5c6d5CpfnVNRzyP15YchCPeiEr52cRWSxUIiGHNoX0NpAVL9KSyDd6EfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757265; c=relaxed/simple;
	bh=Wp3fVL7+QadEa8IzaGlhGIUgVnY7Jv4oi0qCeRl/zp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwMANKilypWah6UJpo3AdCkzyrtXDY7wFob/fThfu8f7YJn0hCS0KZV4RdSmXmmC0Xla41j2v/Ni01agxl9bNpbuJL2Xitb59q1s628/vrauveUKnOsShMBnHxKSFUqX+S37f2/WiqM8ZwLoXPm/eUisxqyL31vqOhcYU6fAif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph3/Qjco; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63bc1aeb427so190281d50.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761757262; x=1762362062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmVcWnyP/D/4k/CbvF/9x81DJvhDtu1WPzap00TJ1+I=;
        b=Ph3/Qjco5azbXJsW3NDTuYpi4IACUBO4d0kSTjZ0jZC72SK790gWA/OyWtD+cestRu
         Fp5ZJf6jzSAsSX7bWcwXcbcE+AmOp1HCYv+EmdbBqPJb1PgzzhjVmY7lMk5/attwM2z7
         Z49pyOIDpy4+HD661ykJk8qndAqClDh6Sjvp3PSnYeih3iBQUkmCrEAeL5DQ3vX0wDM0
         j9PqnT3BBZBrP3wr/wZzz0oCLw5xPXX51m/Flg/gsxxLMLOWVz9iY0FvHNtFKTcdFi83
         eQK6NHCsY8Eb0rbMmj93sKlN0AxrbRfo/ZseBNayi541abgTAoTf31tCNLEntLIM+oOa
         POTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757262; x=1762362062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmVcWnyP/D/4k/CbvF/9x81DJvhDtu1WPzap00TJ1+I=;
        b=FT3JsmdSsXkPyNTdzb4tbp1VaSmpXDORSo7PCF1T3Ga6M0mQOpT0g8oshs/saw55MR
         wR5iZRWfCHGPCzUazmWgKqnQJ1qOTaItEiqAXRDFiz7XK4AbeRF7Z9D3+PQPi3KQgaQ+
         Vtt5qUJk5kXtdn3elArw7Bp4e34XJevayg0RrbIj4Ewr7dbsnMJ3Qlj8q+Oli9eUwfhZ
         rzC6kMLI0fd525qpZlF0VnyNMcR3Ikvycr+gNFNP/BNUfWCswJlD6qjhZWfpkhAWwGT8
         neyJr5ylZ211BN8fXEmQ4Fljk1/iK9EqENn7kdoNBlrUh9UNSOVzRgqyBwIivaV+rxb1
         3/ww==
X-Forwarded-Encrypted: i=1; AJvYcCXfM1bGs7siwapu80nvHB+jWLbuVZm9/xQ7DOO2O92g2UKgDPuC0PXes14HhdPCko7TPj1U0t1M8J/n2q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbD9w3CIRR2WQ0jUpF+hEFUtdb8ex8Xmaxi2o48HroCT9SOzD
	ggBLUxyqiu5u62om1sGEOck0Mk0EfFpi7IlQLG2ttfRXdL6z4KOFbDkz
X-Gm-Gg: ASbGncu61QuaADCULnOqDBTy8gUX2RR3mdqF2Qigrnh9kpmdWa5F/CXowtDA3AfRpYb
	1GghCTGYwx53tP43LifjTonwC2vPta+ESVzTph47t2Xeaw97J89CcK/YXrmwxP8XxVLJtyPjMeD
	eu+ZI094KoKxj6EC0Gc6Uy+VPxtAo3DTDg4qfDrQe0HI34693mwKbNho72UbggvwtKKEX95NhZV
	ddkAORq0yDaGPYV3mqGke1kFeCImORWRkqfGwGPDcMrxBUuIgCjR96gUCJmG2xg7gEPIkoURAP4
	QYqZdFLwkVO2qrw1WFtTtyNBRNLt8ENcMsmHb66wZDA611uL8kaCsBD79MqZ126ZxCkoBlzv5yx
	iDpnImuPxGeGmwca+FaH7iELAE4roNUZYPUlSvldeDIKlPmlo4+rrAHnnNcFY2moLOBDwfSlGLN
	0kVP0eDm9deZeOq8jxpfoelEb/rfIy+HhiK7td
X-Google-Smtp-Source: AGHT+IEnBgJLEOgPmmjd5Fa15mG3hNg+BcjR7XG7Mp5aLAnnOx9JAcZcMN6DeI5kKixpSyz6Fvx1Zw==
X-Received: by 2002:a53:b0cb:0:b0:63f:4b02:cc7e with SMTP id 956f58d0204a3-63f76d6734dmr2393937d50.29.1761757261825;
        Wed, 29 Oct 2025 10:01:01 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c4724b9sm4377534d50.27.2025.10.29.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:01:01 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:00:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQJIS4waEjTCL/hI@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
 <aQJHnfsWll7Di-V0@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJHnfsWll7Di-V0@horms.kernel.org>

On Wed, Oct 29, 2025 at 04:58:05PM +0000, Simon Horman wrote:
> On Mon, Oct 27, 2025 at 12:08:48PM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> > > On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > > > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > > 
> > > > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > > > such as waiting for the server to reach listening state and
> > > > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > > > from hiding failures.
> > > > > 
> > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > 
> > > > shellcheck has some (new) things to say about this patch too.
> > > > Could you take a look over them?
> > > > 
> > > > ...
> > > 
> > 
> > It looks like the errors are SC2317 and SC2119, but are false-positives.
> > Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> > SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> > being passed zero arguments (logging its stdin instead).
> 
> Sorry about that, I thought I saw something meaningful in there.
> I guess I was mistaken.
> 

No problem at all, it brought my attention to shellcheck and the need
for exclusions, which I honestly did not know we used formally upstream.

Best,
Bobby

