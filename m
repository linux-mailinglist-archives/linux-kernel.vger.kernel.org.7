Return-Path: <linux-kernel+bounces-880362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D4C25992
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBFED351C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C03446C4;
	Fri, 31 Oct 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqJAZPms"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D347270545
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921339; cv=none; b=o6P+vSMNMAHqdRPj2JaqzkP6pu6z3NjgB7fCOhOJhEs12NHx0Gl9c49p2D6Qk1v+SsmK7dR+FZvmrBIrDHXZEZD5ON7OUz3ww8bEBdRUjM9MArKHy2HbzbPJlhwPKx5sh+SE2OS2BpV4JTqyOZUGDnjBhI6U/Hu2AZwaclT4I+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921339; c=relaxed/simple;
	bh=AMSI4zE2Da2CoHXVBxERvsBwEjjKt58XBoEtfuiGLlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp8EWzwkG9sY9qd/+KCvHGm9+TTxSOWUj2ag3hGrbNSsgTVobnz6B1N4BkxVvV5TpdtzBt+GdOcGHofRTmNSTe2Cc12KVQ2vZsQZsRootljLytvdjahIiS50w1/RDJ8vKSPQ4WdbUyUZDy82oCPjec1WVtRI5SPjIeMIIKFsVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqJAZPms; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378ddffb497so28616631fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761921336; x=1762526136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhKJuz27wu9b2Q/v2pjgIV8qqd+0+y6WrGE4BcakU/8=;
        b=mqJAZPmsRxzGMJwtLEKgI5sUKxRZs9gdb80UtKbdOCNnffo3CSsnVrW+nq5Rh2Vifw
         CZJuFpBXFPTnNk25sxRg9KZhrKHR8qDTBGSgvBk1+0IWwhTEsS1AmhOSHidpxybATzgZ
         yN+j5wlLSC7VNuRc2O9+p7/G9n/u1mHiM+YmildIMBMHr8wnMy5z16I+zOcYpUJIdXr8
         2skuFjg2/4GN9cgg1DaTQbZoK9kupSwJUxADC+LQm648tPfZBwSK79MVqdP87VDIOtqf
         Yob6FDQ+hhcjtjg4H2Glx2ViyoQM5rGftAvhh97iLL4r9cKERI0/b4aWJWLZt1/yyl17
         Ri0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921336; x=1762526136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhKJuz27wu9b2Q/v2pjgIV8qqd+0+y6WrGE4BcakU/8=;
        b=N/UQlMh6ItWhU/mgavYFfzh3VS0moobgGhU4yTLInSpe24sCkBilnn5CjZNxKvKVMg
         gbPgueQEbcrLvr1Goa8vf1leKAE+XyhcM5OCXvntCuxxoCriWP0OwE+s2sC2/QBtQw/W
         Voxqx7hqpJ/QEK+pTEjOaC2+WrDvLgvMcYr/2GdIw+cC90Umg60MROUidueVINwwLWUM
         CzLoevGi0y8CdWmF17sISu+7g9yiUy4Wb6+skE9rNEK8nl1vEZH7RWFHyZj2BaB39Kc+
         aPwrBRcd3I9itOtCRVvv35bbM+0g0vBiSRzsUzQYSIzzNwcSJArjeXRZ/VItJ6bfyYtu
         TWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbiKBZ6/Ww1E3LAXdChB2wgsHur2ssfjV75KTReJZaIdFu0f663GtZV+QwbmlXIV3HO590kaWenSDfcUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVCIGkc2j/YUlrlO5o2O7FMRj99C0R3p3MUa39UrLnxqxL5Tn
	PdR0ENVrFn6oBBRT62tq4d2XWYtXkrNze68SOAORi2eJhqE6ontVeaZ/tB7MoD5sOWQSa91nbBp
	nK+55mHC+fJXp0qbnzp5DRpZK6/C3z+4=
X-Gm-Gg: ASbGncsH55jDIDD3VKviB2gKqOjukSCp2Lpvefa5JcD4I6dPETya+Am0YVmjQVARWAZ
	QuPTRu4StC3qn0PopLy7h8UDxjsYCGvsBA7oupcHi3ugG8xRVn0vv9psmPk0WTgeoTwXRCUI8v1
	kyQmKEx9fa2/qM94W6wHv6v/+nJ/RQq5mcm6nnlbhUmrvhJfmrlhahwCK1/jEfuF+BRrSkokVix
	ULMTkQiX3muvRXp5/MmtCjPxHBHhQfrTHgVwE4dEah/lb1O8mSLBbrSgI4=
X-Google-Smtp-Source: AGHT+IE59eDz+HM23HuvxjomEE9A/DkvQf7SFbgGyB96I8VG23RpWREEs1gOfdNBEcb7IlhV8UI/s5eCTPxUgw0+bZE=
X-Received: by 2002:a05:651c:4093:b0:36e:f1ae:d4bc with SMTP id
 38308e7fff4ca-37a18d9b72bmr9194001fa.14.1761921335672; Fri, 31 Oct 2025
 07:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031081525.2275894-1-lilinmao@kylinos.cn>
In-Reply-To: <20251031081525.2275894-1-lilinmao@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Oct 2025 10:35:22 -0400
X-Gm-Features: AWmQ_bmuXGhzGerZwZFRtPGqD7WF3harKpEvUmZcQ9sLxynctPfun-jmZXTsBxA
Message-ID: <CABBYNZJZeP1eFZXrVPMAhEtdNVSWkuAkyopLcrUG6wbQpvgsww@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Prevent autosuspend when
 le_scan_disable work is pending
To: Linmao Li <lilinmao@kylinos.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 31, 2025 at 4:15=E2=80=AFAM Linmao Li <lilinmao@kylinos.cn> wro=
te:
>
> When USB autosuspend occurs while le_scan_disable work is scheduled,
> HCI commands sent by the work fail with timeout, leaving LE scan in
> an inconsistent state.
>
> Scenario:
>   T=3D0:     LE scan starts, le_scan_disable work queued (+10240ms)
>   T=3D8s:    Autosuspend check: tx_in_flight=3D0, suspend proceeds
>   T=3D10s:   le_scan_disable work executes on suspended device
>            =E2=86=92 HCI command 0x2042 times out
>
> The tx_in_flight check only protects actively transmitted URBs, missing
> the window where work is queued but hasn't submitted its URB yet.
>
> Fix by checking delayed_work_pending(&hdev->le_scan_disable) during
> autosuspend. Return -EBUSY if pending to block suspend until work
> completes. Only set BTUSB_SUSPENDING after all checks pass to avoid
> leaving the flag set if suspend is aborted.

Hmm, we could also just cancel the work then, in face we do have
hci_suspend_sync->hci_stop_discovery_sync->cancel_delayed_work(&hdev->le_sc=
an_disable);
but perhaps it is not being called always because HCI_LE_SCAN is not
enabled, so I wonder if we should do something like:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1cbdd2ce03f2..59618fde7bcb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5464,6 +5464,11 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)

        bt_dev_dbg(hdev, "state %u", hdev->discovery.state);

+       /* Always stop le_scan_disable since that works as discovery timer =
for
+        * the rounds of discovery irrespective of the discovery type.
+        */
+       cancel_delayed_work(&hdev->le_scan_disable);
+
        if (d->state =3D=3D DISCOVERY_FINDING || d->state =3D=3D DISCOVERY_=
STOPPING) {
                if (test_bit(HCI_INQUIRY, &hdev->flags)) {
                        err =3D __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_=
CANCEL,
@@ -5472,14 +5477,9 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
                                return err;
                }

-               if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-                       cancel_delayed_work(&hdev->le_scan_disable);
-
-                       err =3D hci_scan_disable_sync(hdev);
-                       if (err)
-                               return err;
-               }
-
+               err =3D hci_scan_disable_sync(hdev);
+               if (err)
+                       return err;
        } else {
                err =3D hci_scan_disable_sync(hdev);
                if (err)

We may as well rename/reworkd le_scan_disable to discovery.work since
that acts as I commented above it works as discovery timer not just
le_scan_disable.

> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/bluetooth/btusb.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5e9ebf0c5312..a344ea1dc466 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4389,6 +4389,7 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>  static int btusb_suspend(struct usb_interface *intf, pm_message_t messag=
e)
>  {
>         struct btusb_data *data =3D usb_get_intfdata(intf);
> +       struct hci_dev *hdev =3D data->hdev;
>
>         BT_DBG("intf %p", intf);
>
> @@ -4402,14 +4403,19 @@ static int btusb_suspend(struct usb_interface *in=
tf, pm_message_t message)
>                 return 0;
>
>         spin_lock_irq(&data->txlock);
> -       if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
> -               set_bit(BTUSB_SUSPENDING, &data->flags);
> -               spin_unlock_irq(&data->txlock);
> -       } else {
> +       if (PMSG_IS_AUTO(message) && data->tx_in_flight) {
>                 spin_unlock_irq(&data->txlock);
>                 data->suspend_count--;
>                 return -EBUSY;
>         }
> +       spin_unlock_irq(&data->txlock);
> +
> +       if (PMSG_IS_AUTO(message) && delayed_work_pending(&hdev->le_scan_=
disable)) {
> +               data->suspend_count--;
> +               return -EBUSY;
> +       }



> +
> +       set_bit(BTUSB_SUSPENDING, &data->flags);
>
>         cancel_work_sync(&data->work);
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz

