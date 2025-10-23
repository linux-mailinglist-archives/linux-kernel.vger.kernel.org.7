Return-Path: <linux-kernel+bounces-867400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21729C027EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3284E4F7676
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577C33DEFE;
	Thu, 23 Oct 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hEDceyO/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4233DEF5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238115; cv=none; b=A8M/HuqciAgL1BAUhiAlm1fjf/lIGoX7ZtWlnTDYyU0O2nnZ464iuxHerAzbwJGj51GOal8+um+/1BuAB2QAP2LgegymSJviJbBjX6rUIvJqIbtjQhHAz+Ewc0m3Kd2ZfK0NQfrMKgIYSfJCDlEI9XQY06TALLjjvAAu20IwSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238115; c=relaxed/simple;
	bh=FYNuNzJQUfALIIo2OS88M9jsE9SMndEp7YsFIxmAfnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qonpc9o6VpaDTk20CTzQK0wanXs7kGvO1d4dqm6BOMlK2OfBnQKh59ikhB7+e7PcAFUysjn2oh/60RkEARYWt+Cdyr9vueRVcZ5QSNuJ0U2jm+pyTiUUE0mz6jN9mnrpKzndqAoqFFHz2GbEvv2UcDvvbXJ13JR+jp1IM3jybAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hEDceyO/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so241819666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761238111; x=1761842911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hwlgH/Jwm1lgsle2AVf57DwDHh4FIJzLxRgZAsCOEE=;
        b=hEDceyO/wybL7E3lnNPr8mA9Lfjz0sfyP0mYgncLuA2vRlaH99DjR5NTgOltqQrImj
         EPwVZthxBn2NSi9VjSL5x/QI5Me7wOvSBNWlHHFvr187Ec4B+Zx58IzRZgFjvKkg135h
         23sTZSo2aTBYfYmxXKNHlmswfLJAHGVIH+46U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761238111; x=1761842911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hwlgH/Jwm1lgsle2AVf57DwDHh4FIJzLxRgZAsCOEE=;
        b=aPU8a2+hG99xi3OHkJQCqKzRVHRxFZdR7GNTvinmHQisRjbipMbamrmbJnyHnHgNhZ
         JEgYyz2B+OrVtQx3/ucBOoOsecreN0HxLnZFHf/o3Q0bhDrpXrJM9+uFDykfqJpSqHg6
         0+8RGXduz7ZYFx1jLp1LUrSsDUBY2UAFz8pII6BCZg0/VZLeU9L7951LBw6XSn+fAwcT
         AWEtbYfd5UwD82KN8ghjUh/VZFJBkqBPXtIW3eKJ2waD7OvmvvUWJwEYczP68hRztQJN
         cEudzCyA472hVYy6KRbp9TJgWuNLWCL9MJ7HUxS9wl9kB5rfu+Vy5mjALNkPGGzJu0oj
         4tOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaa4uSIJNtPsKVlcIHSGnGg6X+qWViv6SiSEkMaPampKDV6HZtPQV/yXfA3QahFiKn4KGJk5F0aTD0IZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTMJMaj0kS88WwhGM97I0+rwW8qZje2WwrmoWFxtRQH05PwXb
	faFumFo+6pWvKBZ79Re5hV+AYpiHYzGfHsmw0XS6jHis91n+ckvflzA6428ezUkMnkcvTAOyU0G
	nIHc0AvQTdg==
X-Gm-Gg: ASbGnctU8FNHEgVcU/7GB+RqQuqgYalEDPcp5voGEcCCq7uJrv1GiirBrWGRg4RQRqd
	nhyGJoRVX7CVSyaWBm6HofYZlqtBLpQLsYSjR9w2X5E73CgeM94OMua7COLPDWSNmGFg9owLRdS
	14d79D5rINvj/EVbIsOfn6VnvHesassT6VWZeq0p9HERnJxH8kzeLjJea1rHnkc/BQZAtrRFJl9
	489IOMUpL2rdH/d6EuDW0gKOZgDxqaJ23x+oFSzBfj7HlSGqsBpjDd9zmVAB1Rwk8u2WfvY9T/u
	i23xeSoKisezRl2WFGbG5DxEOpNCnNiKNVsars80xOXc3mHuP5I22uPE/xoQH7ypUEesjX2vW1X
	RTQ0QJKBxHK14N12gK8uXgEDt2FPHck542rrysMqNNTldgDGyD6/s0VAnP8UXQjTBAgEI2ZB5Mo
	SY690HJVbpKZzCxvb74T1YWCE1OF5QyxseYHwmtzTPhXo7vVME1Q==
X-Google-Smtp-Source: AGHT+IF5SQavl/A7VX82GuTE4i1W37sx4ne2ecWVOyNMp96aE2OtvAxBo0TZXyaOzz/GKNylQwna6g==
X-Received: by 2002:a17:906:fe41:b0:b45:a6e6:97b4 with SMTP id a640c23a62f3a-b64764e2fd5mr2950587866b.50.1761238111544;
        Thu, 23 Oct 2025 09:48:31 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51471ef6sm249561066b.72.2025.10.23.09.48.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:48:30 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so219767966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:48:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9GOX+d8uN3UlEIpbTs33Msi5SZNkSgTvU/dV41MKYvm864lggRcFxFwCjRmlzH57Mr8bMy+1Bcp+MGaY=@vger.kernel.org
X-Received: by 2002:a17:907:2d06:b0:b40:cfe9:ed2c with SMTP id
 a640c23a62f3a-b64769cd245mr2845599166b.64.1761238109574; Thu, 23 Oct 2025
 09:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk> <20251023164408.GB2090923@ax162>
In-Reply-To: <20251023164408.GB2090923@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Oct 2025 06:48:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6mxof1=egFUDTNEj3__tCWLTbKjYLzxipVCn6ndXr+g@mail.gmail.com>
X-Gm-Features: AWmQ_bnVmNdsK74q7n823FaHLDwrv3TDkm2pnoZHMOtAws8D_7gQ2A_MzQsBWg8
Message-ID: <CAHk-=wg6mxof1=egFUDTNEj3__tCWLTbKjYLzxipVCn6ndXr+g@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
To: Nathan Chancellor <nathan@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 06:44, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Yeah, this would also be a good conversion example so we could include
> it in kbuild-next with the appropriate Acks. We probably do not want to
> take too many other conversions in the initial pull. If people really
> want to use this in other places for 6.19, we should probably do a
> shared branch for these changes that maintainers could pull into their
> own trees.

Yes. This is a good example of what the use case is and why we're
doing this extension. So Ack both on including it as such, and on the
whole "let's not go overboard with other conversions" thing.

             Linus

