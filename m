Return-Path: <linux-kernel+bounces-839691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADACBB229E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D511C6BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F54C83;
	Thu,  2 Oct 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI6YMVXj"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8606A59
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759365917; cv=none; b=oKIX+WCLAyvzEx8eIdAXzgTxCgOoFSg1RI7UTlZYpXRVfaztz+KMmqzvEgxN+o4jAzTVF1xMS/bmDE/EOJKOktmDcQKKy8c/jNBmOD+0vN1U8fAMsjxL75tT0cVzLq1mvqIcWNtnKUle3CklhIuCoRdhI2Fm8qfK7MuKdaFG2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759365917; c=relaxed/simple;
	bh=eYXSQQCOBx0AoeAywzaSqUtBuZcaA/c8enMbBqJRmeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjqrGGIk1kR4+zMJe/E4TYxeUSdaPhFhceOvdh2yZRotNRIVH4eW5f5HRQo1EfzUL6vc/l5tDMR2auPATmhH1WfqdoULBiNefusd0JPI3RD337nnKbQeH3BhtHxrNmFGLX6azlycXYazmD2ZpmTRr95JV2FqbY9NhQBiBiah5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI6YMVXj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-361d175c97fso3814941fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 17:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759365914; x=1759970714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYXSQQCOBx0AoeAywzaSqUtBuZcaA/c8enMbBqJRmeo=;
        b=YI6YMVXjxasDECSyfuqIgfLQimFdZUezseclRJ3U1b7MChiSJXXd+ZE8ZgS2Uotl56
         0QiAEVPO5aScd1jSVYGk5i0nG/WPm8vEdLixFcP+CsD+y4iKkkEHx/qmvQyfHIDdOxsd
         KzYwGVFuhgEnl+0GUMN0CuP97igQXTb/m4fdU6CJNq471Smam0O/GkL4BThgTeIh+9wy
         dAGkFGsBS0NdmdE6EiwfIoc1aRu1mwk0oZQo59QnbOegE+BSP0+Da+wm3Nd+pWUOayPI
         PoEpy6ah8LLWgqJmRuQzDzgFT4WGVuAM+Wjb3nDd8LssGC+jLa8/cDMXmPQIyglySgcR
         m3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759365914; x=1759970714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYXSQQCOBx0AoeAywzaSqUtBuZcaA/c8enMbBqJRmeo=;
        b=DZPSRBdvAybJMSNh9/YUtK1hkEWxaz2uCPEYTaWkXNrNs75coCqGfoaF1wVwfrP8hq
         rgjhpbqrQGFLrnalh09iHhYLsTKJMosUYcuMrM4KHuA9VyTDfTLjCH3ka3qTbqT0qxrB
         216eUW5+dcNXthUV4Um7xpoEGf6RGqnCP6fw7DSRAJ3bZLCoTvrhoXGQSAoqr5hZduCu
         3Q85VoODhKtYvrTD748sPdEgoK/sdceD6uPfrTdYqrZGM8DlQlR+bOsaAnbIeErn3gFH
         jE1huB8UJMICokxIs6ufEOo/qAuTxEfKOwuLU8b3naJPRoFjOEfKZ8W/p2aTWE1Ck339
         gwYQ==
X-Gm-Message-State: AOJu0YwxUmzAXPbGBnyvHXRCZCz416BVpUTa/ZHeSIzEa5+udTM0sO7G
	b4S9qOi0J/Rs5toqL+nIroGDyixnbdZGQHBudYiBwOWi4IEXdAB5EH9EBqAhW9EpJRWX3tysq7S
	KANajIU5x5hKpMBMrWobAVxltSP/O4NU=
X-Gm-Gg: ASbGncvAOEBScNKqNNx4aOjC0hSLK+5OSAk5uyfRwcfDLD4FXbYIXB3SMmVNKAIzD3W
	pchynMaanZMVb+BGzVlK3V+81qiFYUawvdvJiSrJ4ZbN/AcAraM0mfWvH74jq7slcdY6AF9IWmA
	fh7RDVAP1+07f995uzy2+mdBUs73CgbZ2uuupqN/k1zQGYBybYhOGM+VAs5miaNygqqldKwxqM8
	wuGMYVUq9ofmorUCpYGtKi99wLoQchEc9P2wUsEfcIQJUn/LSDEmmS6jqGgMyQ=
X-Google-Smtp-Source: AGHT+IEGgcOmuRNN+/u9IB+1fTPA8CilMRBZpzFs3XTlIju+nnVo/2PCGU3OVxZIzHv4cJ7tMDlpVfWMvt6J9PueeWk=
X-Received: by 2002:a05:651c:901:b0:36c:7c35:49c8 with SMTP id
 38308e7fff4ca-373a73e1171mr17162341fa.30.1759365913633; Wed, 01 Oct 2025
 17:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <87a52afkxt.fsf@osv.gnss.ru>
In-Reply-To: <87a52afkxt.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 1 Oct 2025 21:45:01 -0300
X-Gm-Features: AS18NWBNynMXlegT-J9agvtAv0CFLBgIIicCf135RfF1kSLeaxCVnf8u-r-iZCw
Message-ID: <CAOMZO5BtovmsZX6E-Yqg9bbDArEw8qvQw5AFK_3sfNNbKWztXA@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Wed, Oct 1, 2025 at 5:04=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:

> Thank you so much for checking! I think I'll try to compare my build to
> this one, as I still have no other idea how to debug my problem. Could
> you please send me resulting DTB file as well so that I can check my
> build system against yours?

I have sent you the dtb off list.

I haven't had a chance to look at your questions yet.

