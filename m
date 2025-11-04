Return-Path: <linux-kernel+bounces-884366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20090C30039
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F4474F8327
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F5313270;
	Tue,  4 Nov 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiU/xdf4"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D12E8DF6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245479; cv=none; b=m7dzSrw1oGFtAl8KJ9UNerG7Cxrp9BIfE2J9079hTeHqRioxR363zNCCBrNUXO8sWfrSxt8Bn48eGJfuOFWp/tIKCThv3OFv9Tj5ro2skeyfeTMI+NQReqOquvKid7Uto0PdJ6em+lrQ7JEaE+1Osxqp+yTqAjjddcy4ZJDX1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245479; c=relaxed/simple;
	bh=d2+eAo6NkfT7+chgCzypmzacmxG0Pw8HOq1CUIxLHSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7+vfuTKzquvbjtXlel9SY4eX+0C3s0xuvXIJrZ3FVXODOBNWVHnqDcFLQN2OfNuYnxBuxYGhfGx72rQYAl95IwEj2qkjgHHsOKtQNI9PNx/5Es4DxOLvkgiUARSP/tZtSQXXUAOTxo1CsjXsxMfMHVwJp9elDBkb+i7NOqclnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiU/xdf4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so4263234a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245476; x=1762850276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2+eAo6NkfT7+chgCzypmzacmxG0Pw8HOq1CUIxLHSY=;
        b=YiU/xdf4LqvdtsBCxz8TWEORFwPFtNFzVKbEMP/6uVQ0bWJvOdprWShz9A4yC4ZVPD
         tMg+e6H0OrfLLvuEk6OzP9B1mNL2MitNCINkJRmTdVxFCILyNYjvM8bRIBiH1yfMDAsb
         aVHmp+xs8Bo7CbmRMbliNzO/MAGzyf9enTApYDE2W3+oW5FRc6TlVgLBNuPRUqZvJN5d
         Sxu6AgFpyYmtHXQ4lwYjqePRTbEJaaRXcM0gZkO8DvBYKGYncWKT5QAifjmTlTB+tl8Q
         zVDHtoVEb09FRtbj0cTmIlC5rj3svhSYzvUUiRSvLbLubKuyzlA2ZVCf7U4199WRxkYW
         A42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245476; x=1762850276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2+eAo6NkfT7+chgCzypmzacmxG0Pw8HOq1CUIxLHSY=;
        b=JplEeW2uKci5Ogbi57V/47jcnTFjnI/8wyOe/7QzPPxJd92XJFM1TCKn52L/n3+tMq
         RDmP20CMtLQXzzjsy/i3uF2k56GssFx7MnlzjTUM2KXu7gQhRAIEk46cZtCtMHC6nPkf
         npfM8KeSZSIzcAsX9jGQgK0li996QlpDq0ySE5ZVnOCZbWGP1p8ShCpFmzAXWLiKx9M1
         NRADggZgsd2+EmWuv0lB6cjYBsKdl50yUTHA9Lifp+8KDUTCW3uFIJjfNnmZZLl7Qg8g
         4wO+/TufBunqNtDgNwWAeXMMi57w80Z6VbHaXQGNkVBpKYK7ueDlXDp+9As2tE4JblDr
         OWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0NF+vi3Ep7it6AnjhdLkpb393fa6igKro8fLFC3WyfbrjzjQ6fdnBt4VI//o9N3eU1UPrrEk4KXWXxn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVah+cdgxdwS0E5ieKbKncr+d9pYYZ7WInWY2AqtJ9rLRU39+
	+bX0LJ+7oZJzaiVVFlK2Tje3DjsXvsfimEswqTjqcBlqjY7HXV0JUbAlJTWNjvH3kEwnPz5CENW
	nqxD60p/MdCazNsQAT52l+wFZtxzvZSg=
X-Gm-Gg: ASbGncuyM/p33J0xdd0KYg0gssXLGOQ57+Wee0gMRzOIuGN2rDjDX9fg5dh7bbwP1aA
	HUxFVZBuNawn1fHNcXk/9MMgyib1JC+8aKDKg4RTrSm7nPMHePqr1W5LOMrQhZRDy+EzGkByKZL
	FKBq4oai/dKtEavZZpIammh4l2c4NqpYRiaYuV42qFOikS00j/Aiq8yjV8+JZnygFeXpTUTwDtM
	jR2McYSJPiClN4a3tsR3CqOEX/f3dkGYgr9YYhCKu0PAlGQlNzWROK3Vkt6aw==
X-Google-Smtp-Source: AGHT+IFQkZHVwcaFP7x6sp3aN9Q9qAekqLNBhM1+eykspKuBoAzSHD59PoifHd7BmivkTUrlh5jggAUNUx1d9Ym1IdM=
X-Received: by 2002:a05:6402:2753:b0:640:6b00:5e93 with SMTP id
 4fb4d7f45d1cf-64077040843mr12588335a12.36.1762245476098; Tue, 04 Nov 2025
 00:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103213656.25912-1-linmag7@gmail.com> <0ba150517e0fd331f1227e068fd37e6e6ea42228.camel@physik.fu-berlin.de>
In-Reply-To: <0ba150517e0fd331f1227e068fd37e6e6ea42228.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 4 Nov 2025 09:37:43 +0100
X-Gm-Features: AWmQ_bkOYl1_jWFedzzvw_vd928e1IEifgTLAjl-givq32aMdK1CdaW33XC_xHg
Message-ID: <CA+=Fv5Sdf732mc2c_xGDsJqq2pS-EQU5d0XLBR7v-0GdgFC5EQ@mail.gmail.com>
Subject: Re: [PATCH] Alpha: MAINTAINERS
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:23=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Magnus,
>
> On Mon, 2025-11-03 at 22:23 +0100, Magnus Lindholm wrote:
> > Add Magnus Lindholm to MAINTAINERS (Alpha port)
>
> I think this message should be in the subject of your patch mail.
>
> Did you use git-send-email to send this patch? If not, you should set it =
up.
>
Hi,

Thanks for the feedback, yes, I used git-send-email. I can put out a v1 of =
this
and update the messages subject accordingly.

Regards

Magnus

