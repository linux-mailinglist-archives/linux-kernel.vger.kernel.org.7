Return-Path: <linux-kernel+bounces-882215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60DFC29E64
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB331883476
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46A286D72;
	Mon,  3 Nov 2025 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH0SKOow"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF083A14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138612; cv=none; b=pcvNU+Horkr7Yunq16C4zso/+qpcoGsnm5lJBgxqU/mEih4nTQFLMZQ1hJcBfCIuZAh8MIRujt7Bpzi4E97aia5CmBtTUhm7vJTIxcTWJGze+5BJrVkCc62dXYcgkJ+tMl+5U17fweR2fmUy0v3TcgI3AdAQLJaKmd0L90x8aJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138612; c=relaxed/simple;
	bh=K3WdlMEenyOlgL7RySRR9VaYppdP5OX+9TrOPWHWI24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/4eNlao/39pQ1A4Gq28jXApLiaCJqSTf8uyrLhpgrn5FCpiAsa4+DQQB7EgUTdz6Tt4oassGyMJaiyMv3kvp5Wcp40ljRolmsAg2TP3qbkGaXDQGgvWOXi1GhbSfeY9EseY9ZsPuYrGaX6cj05M0Uc0Nx0MkGiocV6vpfHGEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH0SKOow; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f2b29b651so405660085a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 18:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762138609; x=1762743409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9M7sgDBGpwY7jPR+4iEMdrWP+dRfhYDD0v9Sn6GaZo=;
        b=CH0SKOowPlfj9FD2XAGS6wRQFAZzK+zv+ij/DZdUDaNAb3YLLCfPGeliawWVeo+zTO
         TV/+xTnNn+CLOM3cX/Kx/WWmKMlo0H5YSp782QQUkek092rnJrKfWOx2eqaEWZK5OwRj
         7Hd5p2nR5cKaKjotuXscr+89jhrEYpMrYa8O09s4i1rezH8OumfiQ0/VndCVl8JMVzTl
         kdICTBg8SRRJ42h3E5AnI6u65tcY+be/bXJQ7TTdEBZfur5Nsi421+fV8zfy3hSV5pGZ
         r9So8Tcg3D1lR3xjCrtqRIi1jzyISlK5+khnRxYz5b1pEWF8G6sQHBlNdtW/Rm9CWxYU
         7NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762138609; x=1762743409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9M7sgDBGpwY7jPR+4iEMdrWP+dRfhYDD0v9Sn6GaZo=;
        b=KJ7lVHRYQPtcocWek/bcZlSmJ+TRmUFs+zbYKYBElfYRDM26/g/DRwxXsFpKDbqkYf
         QLYZY46BewJC4Ccag/pUOtgoQdebrA1o7wIpfwCV6qbTLqLn7eXr7gpYqPOpvvvZoF01
         TIW5JTZxJP9BXxI6OODpIDs67T/EGXI/5jrIFK/vVYsBOj3b0QSISXfImCwt/OZk9ljW
         CeKP2COD/wfWXIStoIAqESUCvHAUJ4xBUv6Z2F5QUYB6XWK2EEmAei2oH0s2Jgnq8Wyv
         s82Y1QHxWrp/OY9ri5s1aH3/doFOGVC27Br4nknHNSpLjCoHy8Re2DvJHj02s2IelJ+o
         1TgA==
X-Forwarded-Encrypted: i=1; AJvYcCVnIyJjc3HXe/gT8EjZN8qOtwPLI+7B1xKI9PLVZYh+7uOkiyw0xdaT/qEuA/UbaCxlkhXWM2agALuKw0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwO8eARZpdT7dkJIgLAcRyD5P0Isdg9N7SwgA426if03lOQLYc
	bpwq5GJ6QXrZCdjtiptUp08jB3X3OvskfvdRJkSTrEktW86dAyAqyLiR
X-Gm-Gg: ASbGncuuiTN2rRNglyB3TI0a578+Q3STKiBUWOnVXYcBt169AoO5nmwy6kw0clAoUsw
	BSvPk2bPuEsQSm4ZM2yW+G3ppD2LWdI0Snqb02u0Gn37YmcckZYrZvwGUHpjvwQVa0opXw6I1eU
	PFOj9rDn5VS9nqqu/qXcUGLsV6NcT5QpjGj4KXzoyL0RMway9CpRLUQLPE0yhjEUA/+sP4IYAD5
	afT9Dw2vTQKvxRz5Wv0PLftRhOztvy6WFlyvCkC7d8FbEJXgdQDreesGm+0OhwDGfpKa2JoVyhg
	+3zyO5DJ5mrOqdQbZPUEV464ieaTkH3U8JGUfPWly/f/W0Instalzw9uTGCXyJ2ftN5nWxJO6HN
	iGEBshtIPbv49xHVKHSTyMbkjvdS+imSwkWV4ThzVHjAOFc23kv7EGyocAl/pKkJhog0T/Tvo/g
	4=
X-Google-Smtp-Source: AGHT+IHE2TSIZgOp5wL5s2nsuoJjILCUj0bEW29KZXQ7lO9JT98njb8YcrMtNBaqpfa3stmMcbDhGA==
X-Received: by 2002:a05:620a:1a0b:b0:891:d993:1bdb with SMTP id af79cd13be357-8ab9bb6e274mr1288436785a.86.1762138609457;
        Sun, 02 Nov 2025 18:56:49 -0800 (PST)
Received: from sam-fedora ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03976ac6sm585893985a.49.2025.11.02.18.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 18:56:49 -0800 (PST)
Date: Sun, 2 Nov 2025 21:56:47 -0500
From: Samuel Kayode <samkay014@gmail.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Lukas Bulwahn <lbulwahn@redhat.com>,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: update PF1550 driver email address
Message-ID: <aQgZ7zfdOHLcMw59@sam-fedora>
References: <20251101-update-email-v2-1-175d221ec40f@gmail.com>
 <zn6q6dsdihb6grnl6qllh26wegtcteh22fn6n6js334kwj2ea5@k2koqqtcvqg7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zn6q6dsdihb6grnl6qllh26wegtcteh22fn6n6js334kwj2ea5@k2koqqtcvqg7>

On Sun, Nov 02, 2025 at 05:33:03PM +0000, Sean Nyekjaer wrote:
> On Sat, Nov 01, 2025 at 04:28:47PM +0100, Samuel Kayode wrote:
> > Update Sam's email address for the PF1550 PMIC driver.
> > 
> 
> Hi Sam,
> 
> Maybe update the .mailmap file with the new mail address?
> 
> /Sean

Will do.

Thanks,
Sam

