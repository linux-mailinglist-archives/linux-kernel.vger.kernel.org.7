Return-Path: <linux-kernel+bounces-787399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53758B375BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5092A5C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387F3090F4;
	Tue, 26 Aug 2025 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyW1fk86"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECB3AC22;
	Tue, 26 Aug 2025 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252483; cv=none; b=KNODjy7hGnJl3L3ghUxhRBts3DgAfYAZ2JKPdFMX+VvvrIMZoiT7hSogsyzICLvbYlOEiRYe/NMoeETukS8/h4jrB2ZBFgYLTr2mIWjwi8fmmdemHq7V5l+00pX18GhoJEB/v3q8w/2LBFfunhQupknxhgfD1KeY+qQaObytZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252483; c=relaxed/simple;
	bh=RdENOwd1RtsgfgrXJESaCgorXIUTKgTsZlPuigpeJjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smSJmRjw3dVo6PZNvW9+IiHun+1C930l6W5lzvjMYBbw36nn+I5LD1ZIu/sePK8rnrgwvBLgle8EAwlOc/FsfwsqCuR2gvwXml4yeBXwx2DAHj0A3RvBuHEUMmoEbM7O6DIi1qtpBM2it8uQmmQH0xw0EEY0e9Kms+KUv9ajxHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyW1fk86; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b471737b347so4022683a12.1;
        Tue, 26 Aug 2025 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756252481; x=1756857281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnuGcmjPhjhi+DRhckbGUIJ6vqUO4YIauvZizEcd4B0=;
        b=ZyW1fk86UMnPffkTcnDzO3fXZi8JGG9Mi7s+3YIJMaYJSAP9gW2+ivRPRscpfCD+8x
         2o1cZ8JAPI8BxrZSj3kxtOvo2u6UiuclzIwxWaj9dvb9NTsBRueBajSVoCC1bbqfpDpx
         rCbykpjdMCqyrpnCP+zaQlOyC9fk6v+ZdYsfTf3fcSwC77Md9p2Abc4gbN6nhY4ThmtS
         YwXlWGCu7xiPfagcYz6OBfyaFpS1QGpCt6eoXdGqUGxRlRjFKDRQ8RIzPhn0y5sgdyyT
         p0+x+Yl0MDb4kJe4wD2zVS5VrbEJ0w9NRpaQrHL20Ndid9IjDUENiCo2eOrUxu6h5rms
         BI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756252481; x=1756857281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnuGcmjPhjhi+DRhckbGUIJ6vqUO4YIauvZizEcd4B0=;
        b=dpyJpJXMGvM9z6zZvvRoov908qHQvrKQeak1pDfLh7runsO8i0ZkslVvf6psRGJvZw
         f9RxY27ZfG0drlL/o25oR0wSV7W5j+L8EhAQP9d7ZEhTuneW4ocg9Guro/uaHNO2pMyY
         GZlwNUYKAmErT+1b/sXhx+A+K/i7hvrblraxiaD808kaUOqidVdw4KMFbr7lxNo8yoI3
         DoNVfw9sjkZMcQazULZ1g77YB6gotQAtYv385atZediVg1cyGy1ZhJOnHLTmiQ/Azh3Z
         uhOOQvhKds8aUjH5sBkj+8/4goME3vyUyMJy0Bbr+lbYHzEMcWcvEptcECxAOHyU8u8X
         dbVg==
X-Forwarded-Encrypted: i=1; AJvYcCVD4YkuHsVvXswP0vqcs7a6ojQZ+GcEAYm4ZfjtsOC7pMFRvYBAXrj5G68XplE4oqaos8nK1mMbStY=@vger.kernel.org, AJvYcCWhR7qT6VahdWZPn8IFqsRb1p8EJXDvgy2GrmZ0KUivkkeYeoLbPNlAXu97cOnJdwKempAWiJB11bIS@vger.kernel.org
X-Gm-Message-State: AOJu0YxysVpLYG48auFqqGqL1sE4eENIngrkiKXvSA9n4yz2YllTwj2n
	7Gk3A4V0rAA1vlnMsmtNe6ai4ej1BaxYZcuFvxaHrZyD+mlsH0XTJRFp
X-Gm-Gg: ASbGncugNhjMS0/WFL+QDS8dkWehEOgnipWmUJKrVDArp0V+ct41Bfq4I4S4ciYaf0C
	ushhFK44UHaKCMtz32VsKSQ6JJLuTHgCA14hEe3glfgjxMMFU+oLQtN9cVfsSDV41A3j9gNwWFh
	js1iZC0m0Y227+YBe7cK4rlufToOoMseCRQe++kPif18T/2bcp2+Hb/EUj2TNnMHAtfbrfJqv8t
	DeFOyE5mggKmAW6nzsQCJL5tT71ukVg/0wQ8Oz64JXlG6oaFkUEMbyL2dvwxfRBPNostsrB2O2+
	ihIE1eA5qmS5oOnpAXe4IuTxdD90IHOz4+pVG9aP0/F2YzowBlaso7BCSHy1P5rhgOO6xSRlDzK
	jbCqFJpECg99K3BqvDsU/6w==
X-Google-Smtp-Source: AGHT+IFDc+YGdHj3Jh3BAAJZez7aNxo8el4TTaNrwADmK0oOrPWX2EzNex2c4ccfinIri15m/Eqt2Q==
X-Received: by 2002:a17:902:db0c:b0:245:f5a7:1b7c with SMTP id d9443c01a7336-2462ee2bab0mr246624295ad.11.1756252481210;
        Tue, 26 Aug 2025 16:54:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687ceda5sm106460745ad.63.2025.08.26.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:54:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9F2A241E4F06; Wed, 27 Aug 2025 06:54:38 +0700 (WIB)
Date: Wed, 27 Aug 2025 06:54:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
Message-ID: <aK5JPhkPxJ3MSr74@archie.me>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
 <87349ed6zj.fsf@trenco.lwn.net>
 <20250826-fearless-glossy-dinosaur-46ebbf@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CYJ6GTH0OxX2HL+i"
Content-Disposition: inline
In-Reply-To: <20250826-fearless-glossy-dinosaur-46ebbf@lemur>


--CYJ6GTH0OxX2HL+i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:46:50AM -0400, Konstantin Ryabitsev wrote:
> I do believe this is a clear indicator that the whole sentence needs to be
> reworded:
>=20
>     ... if somebody tells you to "choose (a) or (b), we really need you to
>     decide on this," you're in trouble as a manager. The people you manage
>     most likely know the details better than you, so if they come to you =
for
>     a technical decision, ...
>=20
> This change would detract from the... unique... style of this document, b=
ut
> would hopefully be less confusing to non-native speakers.

Thanks for the suggestion!

--=20
An old man doll... just what I always wanted! - Clara

--CYJ6GTH0OxX2HL+i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaK5JPgAKCRD2uYlJVVFO
o9AQAP9PQyW036PwTuvohvdSfIjUrPHhO98NKzZSKcC2G4GW4AEAr60OUf4sibgk
alcfUMhMYxR00FWox2pho3BneI+joAw=
=03a8
-----END PGP SIGNATURE-----

--CYJ6GTH0OxX2HL+i--

