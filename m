Return-Path: <linux-kernel+bounces-737733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D91B0AFE7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FCA179ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECE238C08;
	Sat, 19 Jul 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH6NOkrZ"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2896F9E8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928532; cv=none; b=rRQghbegVucFgkBjzAJHR0YO946b3aHvKlkF+ah2u3R7SVokFZt7nVv4Z28Rj9dIeOo4duHAcYMZa9dUyztxG+1a+iY9QOFcuqA+Ri7ImhzhToVs5UT+juNhXjoHcuvt2rZ/CYuaYqPGyYzuvCXd59l+PvF1rEWJbp/VZnJ1aZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928532; c=relaxed/simple;
	bh=4Y61ezedNlasNuguew5yc/qYVWkZkiIOi2FvberhkQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhQpIwJhkQbqRbayg4idqIq0XnF8xCqyowW9LuazDFPoz0VPi8x5Kjn8nE+cNaQC/0jyw0BsjmpcoOxwcWHs7WR/L945cFGYkk8DW+43SgPpjpGPriF3wdH6fYe5JppiKxkxApC1A9DG1uwecbU7WHdzybu4vHzAp26O45X44zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH6NOkrZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6facacf521eso26234276d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928530; x=1753533330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y61ezedNlasNuguew5yc/qYVWkZkiIOi2FvberhkQQ=;
        b=IH6NOkrZMDVhUhuy2T9zuDQowkSpuROuEBfeSiWmRaxFnZn0RsLt9MkQmqCMxjio21
         MCAhj20rtpOEBRJH5i/HxFDcv4oyqPDhCZg1UlpVzX54e28UIj4a79vjN+ungF3yMv+v
         ktQ+TP7QaN+igYP9IMPqThfBLbqwQ1FbQy23/5KKUNg1LsaFFZG5ojjScREhYNgqaL/U
         7TTm6bpgp1SdQlyVCgj0ddmFnsWiwf7kc5NIGJZm3sJSqSjCOmh7YBQZA/c/khU3IAdR
         jL3N8hKXT4m5d+sevLTINS3HnV6un+Gg6rZiWDl9sop7xlkDOJsxQ1DsXjCUpB4l6QYn
         fYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928530; x=1753533330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y61ezedNlasNuguew5yc/qYVWkZkiIOi2FvberhkQQ=;
        b=DbbvtIV61D/Thxv6vohk4aXZ37kiIiKBQ/Q29H5Yj/mh29bvKlZYtb9W1DwgJ8ZAeR
         1qvFGHeEBas+3qjqXiRhGUNG5g+7TQ9VnfTb42L58efSrdbmaY+5mek/BLqm6CmQy38Q
         8PCVniHxtBYN8ykqf+UuAWQS+fxhJQvvRgj58NBbpi1vUoPfbwvtBzACg6oKBiEDV7Xj
         oycY3JmJBzo5bR0/whhyX7uJ0gAgb0MSKlSSiBjD7ZFN6Z7nNBEQeNk3RzvXiglp0etT
         0+6uwCz4A2roEn6hfXWJWGWRliX0IKUrdzUVCrqdD34+jaQch1nVnU4vSAz/JPL3t/pw
         /lxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPTTRrYVvBxeLwhWjNRdi9PmEa8L5UXyBzrfCXcLDv5LJHKmmKp13E0O12nqXQMqyCX9eQ1Gt/Arv83e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa4ZCY8tq1betrbniIqEAy/XIhar1p0Fs9TvAh8rQK+tTNLwY
	YiwNOIn/NXPNWiE2LftwGSpb4q2UaPAcvO4Hr/1Avu/pHR0w2Mw4OToky6i14aUQ
X-Gm-Gg: ASbGncsyfk1jQYGbnRntdyY5P1iuPHb59tUuiV3mos2NeyEZYTUtBwD1ypy/MEWQFjr
	3cjcswRFRLohZ7Tobdm5uxDTKw1R4Ib9jo85trTXUpn9ZVijeDr8YQ5dOVle+KqW+Bja9aZxDOv
	9jDxXbH4Cxp/1OeOr8lLgwJcnDzzg6rpHTkUm+OTSN6B5JvEUgiaSyYEM48z9dYgR4imxhlxCHX
	mYvZT/mvMVYqYQ/W9yup9ImQ3/gWck3IrDQFiyjysdPHCGUMRXBUFpejAbwpGeHJkTeH2309Gn7
	fZonFZNTNoOJ1NJW7NM5BHOHStsA9jhwDFBwSMt+5usKoCSMWxNimaXHTfxK6FioZEvufLwa2+Z
	cN3Pb1AWO2Awang==
X-Google-Smtp-Source: AGHT+IHJA+QRPflJYc7M8xzBI0EQypb5RolX8qrCsFpoC25cIFIq9h+6eg9e7GqTk3uzfky4dIMm8w==
X-Received: by 2002:a05:6214:5c08:b0:6fd:ace:4cf8 with SMTP id 6a1803df08f44-705073a3be4mr108216856d6.30.1752928529605;
        Sat, 19 Jul 2025 05:35:29 -0700 (PDT)
Received: from pc ([196.235.158.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49a0147sm19223221cf.21.2025.07.19.05.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:35:29 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:35:26 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <aHuRDhvUbVt9kcxa@pc>
References: <aHskWESzZdyBFj4x@pc>
 <f2f794bc-7c0c-ae18-70bc-97c7ffa8e235@outbound.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f794bc-7c0c-ae18-70bc-97c7ffa8e235@outbound.gmail.com>

You are welcome

Best regards,
Salah Triki

